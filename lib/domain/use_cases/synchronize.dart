import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/repositories/synchronization_repository.dart';

abstract class Synchronize {
  Future<List<PendingRegistration>> call(List<PendingRegistration> registrations, List<Project> projects);
}

class SynchronizeImpl implements Synchronize {
  
  final SynchronizationRepository repository;

  SynchronizeImpl({required this.repository});

  @override
  Future<List<PendingRegistration>> call(List<PendingRegistration> registrations, List<Project> projects) async {
    //Se realiza la sincronización únicamente con los registros pendientes
    final pendingRegistrations = registrations.where(
      (r) => r.status == .pending
    ).toList();
    final synchronized = await repository.synchronize(pendingRegistrations);
    // Se obtienen los sincronizados exitosamente y los repetidos por aparte
    final succesfullySynchronized = <PendingRegistration>[];
    final repeated = <int>[];
    for(int i = 0; i < synchronized.length; i++) {
      final sync = synchronized[i];
      if(sync.status == .success) {
        final registration = pendingRegistrations[i].copyWith(
          status: .completed,
          remoteAttendanceId: sync.remoteAttendanceId
        );
        succesfullySynchronized.add(registration);
      } else if (sync.status == .repeated) {
        repeated.add(pendingRegistrations[i].localAttendanceId);
      }
    }
    //Se actualizan los registros exitosos en la base de datos
    await repository.markAsSynchronized(succesfullySynchronized);
    
    //Se obtienen los últimos registros para devolver el estado actualizado
    var lastRegistrations = await repository.getLastRegistrations(projects);
    lastRegistrations = lastRegistrations.map<PendingRegistration>(
      (r) {
        final synchronizedIndex = synchronized.indexWhere(
          (s) => s.localAttendanceId == r.localAttendanceId &&
          (s.type == null || s.type == r.registration.type)
        );
        if(synchronizedIndex != -1) {
          final s = synchronized[synchronizedIndex];
          if(s.status == .failure) {
            return r.copyWith(
              status: .canceled
            );
          } else if(s.status == .repeated) {
            return r.copyWith(
              status: .repeated
            );
          }
          
        }
        return r;
      }
    ).toList();
    //Se eliminan los registros repetidos de la base de datos después de obtener los últimos registros
    await repository.removeRegistrations(repeated.toSet().toList());
    return lastRegistrations;
  }
  
}