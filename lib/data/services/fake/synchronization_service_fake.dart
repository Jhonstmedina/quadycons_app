import 'package:quadycons/data/services/dto/registration_result_dto.dart';
import 'package:quadycons/data/services/synchronization_service.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';

class SynchronizationServiceFake implements SynchronizationService {
  @override
  Future<List<RegistrationResultDTO>> synchronize(List<PendingRegistration> registrations, _) {
    /*
    return Future.delayed(
      Duration(seconds: 1),
      () => registrations.map(
        (r) => RegistrationResultDTO(
          tempId: r.localAttendanceId,
          asistenciaId: 1000 + r.localAttendanceId,
          estado: 'exitoso',
          mensaje: 'Entrada registrada correctamente'
        )
      ).toList()
    );
    */
    return Future.delayed(
      Duration(seconds: 1),
      () => [
        RegistrationResultDTO(
          tempId: registrations[0].localAttendanceId,
          asistenciaId: 1000 + registrations[0].localAttendanceId,
          estado: 'exitoso',
          mensaje: 'Entrada registrada correctamente'
        ),
        RegistrationResultDTO(
          tempId: registrations[1].localAttendanceId,
          asistenciaId: 1000 + registrations[1].localAttendanceId,
          estado: 'exitoso',
          mensaje: 'Salida registrada correctamente'
        ),
        RegistrationResultDTO(
          tempId: registrations[2].localAttendanceId,
          asistenciaId: 1000 + registrations[2].localAttendanceId,
          estado: 'ya_sincronizado',
          mensaje: 'Registro ya existía completo, no se modificó'
        ),
        RegistrationResultDTO(
          tempId: registrations[3].localAttendanceId,
          asistenciaId: 1000 + registrations[3].localAttendanceId,
          estado: 'ya_sincronizado',
          mensaje: 'Registro ya existía completo, no se modificó'
        ),
        RegistrationResultDTO(
          tempId: registrations[4].localAttendanceId,
          asistenciaId: 1000 + registrations[4].localAttendanceId,
          estado: 'error',
          mensaje: 'Registro ya existía completo, no se modificó'
        ),
        RegistrationResultDTO(
          tempId: registrations[5].localAttendanceId,
          asistenciaId: 1000 + registrations[5].localAttendanceId,
          estado: 'error',
          mensaje: 'Registro ya existía completo, no se modificó'
        )
      ]
    );
  }

}