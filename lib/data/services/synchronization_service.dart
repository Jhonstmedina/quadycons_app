import 'package:flutter/material.dart';
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
              'trabajador_cedula': r.registration.idCodeInfo.docNumber,
              'proyecto_id': r.registration.idCodeInfo.worker!.project!.id,
              'fecha': r.registration.check.time.toIso8601String(),
              'hora_entrada': TimeOfDay.fromDateTime( r.registration.check.time).toString(),
              'latitud_entrada': r.registration.check.location.lat,
              'longitud_entrada': r.registration.check.location.lon,
              'tipo': r.registration.type
            } : {
              'asistencia_temp_id': r.localAttendanceId,
              'hora_salida': TimeOfDay.fromDateTime(r.registration.check.time).toString(),
              'latitud_salida': r.registration.check.location.lat,
              'longitud_salida': r.registration.check.location.lon,
              'tipo': r.registration.type

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
}