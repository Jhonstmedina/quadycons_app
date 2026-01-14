import 'package:quadycons/data/entities/id_code_info.dart';
import 'package:quadycons/data/entities/lat_lng.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/code_scan_service.dart';
import 'package:quadycons/domain/repositories/code_scan_repository.dart';

class CodeScanRepositoryImpl implements CodeScanRepository {
  final CodeScanService service;
  final AccessTokenGetter accessTokenGetter;

  CodeScanRepositoryImpl({
    required this.service,
    required this.accessTokenGetter
  });

  @override
  Future<IdCodeInfo> getInfoByIdBase(IdCodeInfo baseInfo) async {
    final accessToken = await accessTokenGetter.getAccessToken();
    final worker = await service.getInfoByIdentification(baseInfo.docNumber, accessToken);
    return IdCodeInfo(
      docNumber: baseInfo.docNumber,
      worker: worker
    );
  }

  @override
  Future<LatLng> getFence() async {
    final accessToken = await accessTokenGetter.getAccessToken();
    return await service.getFence(accessToken);
  }
}