import 'package:quadycons/domain/entities/id_code_info.dart';

abstract class CodeScanRepository {
  Future<IdCodeInfo> getInfoByIdBase(IdCodeInfo baseInfo);
}