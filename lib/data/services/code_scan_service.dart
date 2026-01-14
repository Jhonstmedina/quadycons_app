import 'package:quadycons/data/entities/id_code_info.dart';
import 'package:quadycons/data/entities/lat_lng.dart';
import 'package:quadycons/data/services/service.dart';

abstract class CodeScanService {
  Future<Worker> getInfoByIdentification(String code, String accessToken);
  Future<LatLng> getFence(String accessToken);
}

class CodeScanServiceImpl extends Service implements CodeScanService {
  CodeScanServiceImpl({required super.dio});

  @override
  Future<Worker> getInfoByIdentification(String code, String accessToken) async {
    //TODO: Implementar
    throw UnimplementedError();
  }
  
  @override
  Future<LatLng> getFence(String accessToken) async {
    // TODO: implement getFence
    throw UnimplementedError();
  }
}
