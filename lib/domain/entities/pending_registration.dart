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

  PendingRegistration copyWith({
    Registration? registration,
    int? attendanceLocalId,
    int? attendanceRemoteId,
    RegistrationStatus? status
  }) => PendingRegistration(
    registration: registration ?? this.registration,
    attendanceLocalId: attendanceLocalId ?? this.attendanceLocalId,
    attendanceRemoteId: attendanceRemoteId ?? this.attendanceRemoteId,
    status: status ?? this.status
  );
}