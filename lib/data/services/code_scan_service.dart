import 'package:dio/dio.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/data/services/service.dart';

abstract class CodeScanService {
  Future<Worker> getInfoByIdentification(String idDocument, String accessToken);
}

class CodeScanServiceImpl extends Service implements CodeScanService {
  CodeScanServiceImpl({required super.dio});

  @override
  Future<Worker> getInfoByIdentification(String idDocument, String accessToken) async {
    final response = await super.executeDioService(
      () async => await dio.get(
        'trabajadores/por-cedula/$idDocument',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken'
          }
        )
      )
    );
    final result = response.data;
    return Worker(
      id: result['id'],
      name: '${result['nombre']} ${result['apellido']}',
      profileUrl: result['foto_cedula'],
      position: result['cargo'],
      projectId: result['proyecto_actual']['id']
    );
  }
}
