import 'package:quadycons/data/services/dto/registration_result_dto.dart';
import 'package:quadycons/data/services/service.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/register_type.dart';

abstract class SynchronizationService {
  Future<List<RegistrationResultDTO>> synchronize(List<PendingRegistration> registrations, String accessToken);
}

class SynchronizationServiceImpl extends Service implements SynchronizationService {
  SynchronizationServiceImpl({required super.dio});

  @override
  Future<List<RegistrationResultDTO>> synchronize(List<PendingRegistration> registrations, String accessToken) async {
    final result = await super.executeDioService(() async => 
      dio.post(
        'asistencias/sincronizar/',
        options: super.getBaseOptions(accessToken),
        data: {
          'asistencias': registrations.map(
            (r) => r.registration.type == RegisterType.checkIn ? {
              'asistencia_temp_id': r.localAttendanceId,
              if (r.registration.idCodeInfo.docNumber.isNotEmpty)
                'trabajador_cedula': r.registration.idCodeInfo.docNumber,
              if (r.registration.idCodeInfo.worker?.id != null)
                'trabajador_id': r.registration.idCodeInfo.worker!.id,
              'proyecto_id': r.registration.idCodeInfo.worker!.project!.id,
              'fecha': _dateToString(r.registration.check.time),
              'hora_entrada': _dateToStringTime(r.registration.check.time),
              'latitud_entrada': r.registration.check.location.lat,
              'longitud_entrada': r.registration.check.location.lon,
              'tipo': 'entrada'
            } : {
              'asistencia_temp_id': r.localAttendanceId,
              'hora_salida': _dateToStringTime(r.registration.check.time),
              'latitud_salida': r.registration.check.location.lat,
              'longitud_salida': r.registration.check.location.lon,
              'tipo': 'salida'

            }
          ).toList()
        }
      )
    );
    final data = result.data as Map<String, dynamic>;
    return (data['resultados'] as List).cast<Map<String, dynamic>>()
      .map(
        (r) => RegistrationResultDTO(
          tempId: r['temp_id'],
          asistenciaId: r['asistencia_id'],
          estado: r['estado'],
          mensaje: r['mensaje']
        )
      ).toList();
  }

  /*
   * Formato: YYYY-MM-DD
  */
  String _dateToString(DateTime date) {
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  /*
  * Formato: HH:MM
  */
  String _dateToStringTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}