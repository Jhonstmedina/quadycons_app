import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/project.dart';

abstract class CodeScanRepository {
  Future<IdCodeInfo> getInfoByIdBase(IdCodeInfo baseInfo, Project project);
}