import 'package:quadycons/domain/entities/registration.dart';

class PendingRegistration {
  final Registration registration;
  final int? attendanceRemoteId;
  final int attendanceLocalId;
  PendingRegistration({
    required this.registration,
    required this.attendanceRemoteId,
    required this.attendanceLocalId
  });
}