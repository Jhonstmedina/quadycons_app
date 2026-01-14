import 'package:quadycons/data/entities/registration.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';

class RegisterConfirmationServiceFake implements RegisterConfirmationService {
  @override
  Future<Registration> confirmRegistration(Registration registration, String accessToken) async {
    await Future.delayed(const Duration(seconds: 1));
    return registration;
  }

}