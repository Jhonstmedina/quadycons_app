import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/domain/entities/registration_status.dart';

class PendingRegistration {
  final Registration registration;
  final int localAttendanceId;
  final int? remoteAttendanceId;
  final RegistrationStatus status;
  
  PendingRegistration({
    required this.registration,
    required this.localAttendanceId,
    this.remoteAttendanceId,
    required this.status
  });

  PendingRegistration copyWith({
    Registration? registration,
    int? localAttendanceId,
    int? remoteAttendanceId,
    RegistrationStatus? status
  }) => PendingRegistration(
    registration: registration ?? this.registration,
    localAttendanceId: localAttendanceId ?? this.localAttendanceId,
    remoteAttendanceId: remoteAttendanceId ?? this.remoteAttendanceId,
    status: status ?? this.status
  );
}