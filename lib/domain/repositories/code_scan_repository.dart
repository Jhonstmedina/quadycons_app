import 'package:quadycons/data/entities/id_code_info.dart';
import 'package:quadycons/data/entities/lat_lng.dart';

abstract class CodeScanRepository {
  Future<IdCodeInfo> getInfoByIdBase(IdCodeInfo baseInfo);
  Future<LatLng> getFence();
}