import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/repositories/synchronization_repository.dart';

abstract class CleanLastRegistrations {
  Future<List<PendingRegistration>> call(List<PendingRegistration> registrations);
}

class CleanLastRegistrationsImpl implements CleanLastRegistrations {

  final SynchronizationRepository repository;
  CleanLastRegistrationsImpl({required this.repository});
  
  @override
  Future<List<PendingRegistration>> call(List<PendingRegistration> registrations) async {
    //TODO: Implementar funcionalidad en repositorio
    final cleanedRegistrations = registrations.where(
      (r) => r.status != .completed
    ).toList();
    return cleanedRegistrations;
  }
  
}