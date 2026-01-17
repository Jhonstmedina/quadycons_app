import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';

abstract class CodeScanRepository {
  Future<IdCodeInfo> getInfoByIdBase(IdCodeInfo baseInfo);
  Future<LatLng> getFence();
}