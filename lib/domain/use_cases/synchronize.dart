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
    final pendingRegistrations = registrations.where(
      (r) => r.status == .pending
    ).toList();
    final synchronized = await repository.synchronize(pendingRegistrations);
    final succesfullySynchronized = <PendingRegistration>[];
    for(int i = 0; i < synchronized.length; i++) {
      final sync = synchronized[i];
      if(sync.status == .success) {
        final registration = pendingRegistrations[i].copyWith(
          status: .completed,
          remoteAttendanceId: sync.remoteAttendanceId
        );
        succesfullySynchronized.add(registration);
      }
    }
    
    await repository.markAsSynchronized(succesfullySynchronized);
    return await repository.getPendingRegistrations(projects);
  }
  
}