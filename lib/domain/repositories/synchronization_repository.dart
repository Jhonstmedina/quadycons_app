import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/registration_result.dart';

abstract class SynchronizationRepository {
  Future<List<PendingRegistration>> getPendingRegistrations(List<Project> projects);
  Future<List<RegistrationResult>> synchronize(List<PendingRegistration> registrations);
  Future<void> markAsSynchronized(List<PendingRegistration> registrations);
  Future<void> removeRegistrations(List<int> attendancesIds);
}