import 'package:quadycons/data/services/dto/registration_result_dto.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/registration_result.dart';

class RegistrationResultMapper {
  static RegistrationResult toDomain(RegistrationResultDTO result) => RegistrationResult(
    localAttendanceId: result.tempId,
    remoteAttendanceId: result.asistenciaId,
    status: result.estado == 'exitoso'?
      RegistrationResultStatus.success :
      RegistrationResultStatus.failure,
    type: (result.mensaje).contains('Entrada')?
      RegisterType.checkIn :
      RegisterType.checkOut
  );
}