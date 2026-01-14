import 'package:quadycons/data/entities/registration.dart';
import 'package:quadycons/data/services/service.dart';

abstract class RegisterConfirmationService {
  Future<Registration> confirmRegistration(Registration registration, String accessToken);
}

class RegisterConfirmationServiceImpl extends Service implements RegisterConfirmationService {
  RegisterConfirmationServiceImpl({required super.dio});

  @override
  Future<Registration> confirmRegistration(Registration registration, String accessToken) async {
    // TODO: implement confirmRegistration
    throw UnimplementedError();
  }
  
}