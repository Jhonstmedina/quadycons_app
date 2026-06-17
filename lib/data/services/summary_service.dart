import 'package:dio/dio.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import 'package:quadycons/data/services/service.dart';

abstract class SummaryService {
  Future<SummaryDTO> getSummaryToday(String accessToken, int projectId);
}

class SummaryServiceImpl extends Service implements SummaryService {
  SummaryServiceImpl({required super.dio});

  @override
  Future<SummaryDTO> getSummaryToday(String accessToken, int projectId) async {
    final response = await super.executeDioService(
      () async => await dio.get(
        'asistencias/resumen-hoy/',
        queryParameters: {'proyecto_id': projectId},
        options: super.getBaseOptions(accessToken),
      ),
    );
    final data = response.data;
    final totales = data['totales'];
    return SummaryDTO(
      inputs: totales['entradas'] ?? 0,
      outputs: totales['salidas'] ?? 0,
      pending: totales['pendientes'] ?? 0,
      absent: totales['ausentes'] ?? 0,
    );
  }
}
