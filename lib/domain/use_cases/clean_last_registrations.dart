import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/repositories/synchronization_repository.dart';

abstract class CleanLastRegistrations {
  Future<List<PendingRegistration>> call(List<PendingRegistration> registrations, List<Project> projects);
}

class CleanLastRegistrationsImpl implements CleanLastRegistrations {

  final SynchronizationRepository repository;
  CleanLastRegistrationsImpl({required this.repository});
  
  @override
  Future<List<PendingRegistration>> call(List<PendingRegistration> registrations, List<Project> projects) async {
    var cleanedRegistrations = <PendingRegistration>[];
    for(int i = 0; i < registrations.length; i++) {
      final current = registrations[i];
      if(current.status == .completed) {
        if(current.registration.type == .checkIn &&
          registrations.any(
            (r) => r.localAttendanceId == current.localAttendanceId &&
              r.registration.type == .checkOut &&
              r.status == .completed
          )
        ) {
          cleanedRegistrations.add(current);
        } else if(current.registration.type == .checkOut) {
          cleanedRegistrations.add(current);
        }
      }
    }
    final cleanedAttendances = cleanedRegistrations.map((e) => e.localAttendanceId).toSet().toList();
    await repository.removeRegistrations(cleanedAttendances);
    return await repository.getLastRegistrations(projects);
  }
  
}