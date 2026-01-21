import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/domain/entities/registration_status.dart';

class PendingRegistration {
  final Registration registration;
  final int attendanceLocalId;
  final int? attendanceRemoteId;
  final RegistrationStatus status;
  
  PendingRegistration({
    required this.registration,
    required this.attendanceLocalId,
    this.attendanceRemoteId,
    required this.status
  });
}