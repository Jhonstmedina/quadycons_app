import 'package:quadycons/data/entities/registration.dart';

abstract class RegisterConfirmationRepository {
  Future<Registration> confirmRegistration(Registration registration);
}