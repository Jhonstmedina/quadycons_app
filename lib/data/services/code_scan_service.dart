import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/data/services/service.dart';
import 'package:quadycons/domain/entities/project.dart';

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
        options: super.getBaseOptions(accessToken)
      )
    );
    final result = response.data;
    return Worker(
      id: result['id'],
      name: result['nombre_completo'],
      profileUrl: result['foto_cedula'] ?? result['foto_url'],
      position: result['puesto_laboral'] ?? result['cargo'],
      project: Project(
        id: result['proyecto_asignado_info']['id'],
        name: result['proyecto_asignado_info']['nombre'],
        geoLocation: null,
        geoFence: null
      )
    );
  }
}
