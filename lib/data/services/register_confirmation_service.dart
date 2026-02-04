import 'package:dio/dio.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/data/services/service.dart';
import 'package:quadycons/domain/exceptions.dart';

abstract class RegisterConfirmationService {
  Future<Attendance> confirmCheckIn(Registration registration, String accessToken);
  Future<Attendance> confirmCheckOut(Attendance attendance, String accessToken);
}

class RegisterConfirmationServiceImpl extends Service implements RegisterConfirmationService {
  RegisterConfirmationServiceImpl({required super.dio});
  
  @override
  Future<Attendance> confirmCheckIn(Registration registration, String accessToken) async {
    late Response<dynamic> result;
    try{
      result = await super.executeDioService(
        () async => await dio.post(
          'asistencias/check-in/',
          options: super.getBaseOptions(accessToken),
          data: {
            'trabajador_cedula': registration.idCodeInfo.docNumber,
            'proyecto_id': registration.idCodeInfo.worker!.project!.id,
            'latitud': registration.check.location.lat,
            'longitud': registration.check.location.lon
          }
        )
      );
    } on ServerException catch (e) {
      if(e.statusCode == 403) {
        throw GeneralException(message: 'Fuera de geocerca en check-in');
      } else {
        rethrow;
      }
    } on Object {
      rethrow;
    }
    var data = result.data;
    if(data['asistencia'] != null) {
      data = data['asistencia'];
    }
    final dateParts = data['fecha'].split('-');
    final timeParts = data['hora_entrada'].split(':');
    final checkInTime = DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1])
    );
    return Attendance(
      remoteId: data['id'],
      checkin: Check(
        time: checkInTime,
        location: registration.check.location
      ),
      checkout: null,
      idCodeInfo: registration.idCodeInfo
    );
  }
  
  @override
  Future<Attendance> confirmCheckOut(Attendance attendance, String accessToken) async {
    late Response<dynamic> result;
    try{
      result = await super.executeDioService(
        () async => await dio.post(
          'asistencias/check-out/',
          options: super.getBaseOptions(accessToken),
          data: {
            'asistencia_id': attendance.remoteId,
            'latitud': attendance.checkout!.location.lat,
            'longitud': attendance.checkout!.location.lon
          }
        )
      );
    } on ServerException catch (e) {
      if(e.statusCode == 403) {
        throw GeneralException(message: 'Fuera de geocerca en check-out');
      } else {
        rethrow;
      }
    } on Object {
      rethrow;
    }
    var data = result.data;
    if(data['asistencia'] != null) {
      data = data['asistencia'];
    }
    final dateParts = data['fecha'].split('-');
    final timeParts = data['hora_salida'].split(':');
    final checkOutTime = DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
      int.parse(timeParts[0]),
      int.parse(timeParts[1])
    );
    return Attendance(
      id: attendance.id,
      remoteId: data['id'],
      checkin: attendance.checkin,
      checkout: Check(
        time: checkOutTime,
        location: attendance.checkout!.location
      ),
      idCodeInfo: attendance.idCodeInfo
    );
  }
  
}