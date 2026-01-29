import 'package:quadycons/domain/entities/register_type.dart';

enum RegistrationResultStatus {
  success,
  failure,
  repeated
}

class RegistrationResult {
  final int? localAttendanceId;
  final int remoteAttendanceId;
  final RegistrationResultStatus status;
  final RegisterType type;
  RegistrationResult({
    required this.localAttendanceId,
    required this.remoteAttendanceId,
    required this.status,
    required this.type
  });
}