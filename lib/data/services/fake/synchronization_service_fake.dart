import 'package:quadycons/data/services/dto/registration_result_dto.dart';
import 'package:quadycons/data/services/synchronization_service.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';

class SynchronizationServiceFake implements SynchronizationService {
  @override
  Future<List<RegistrationResultDTO>> synchronize(List<PendingRegistration> registrations, _) {
    return Future.delayed(
      Duration(seconds: 1),
      () => <RegistrationResultDTO>[]
    );
  }

}