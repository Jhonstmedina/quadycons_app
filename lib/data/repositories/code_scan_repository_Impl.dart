import 'package:quadycons/core/connectivity/connectivity_service.dart';
import 'package:quadycons/data/db/daos/worker_dao.dart';
import 'package:quadycons/data/db/mappers/worker_mapper.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/code_scan_service.dart';
import 'package:quadycons/domain/repositories/code_scan_repository.dart';

class CodeScanRepositoryImpl implements CodeScanRepository {
  final CodeScanService service;
  final AccessTokenGetter accessTokenGetter;
  final WorkersDao dao;
  final ConnectivityService connectivityService;

  CodeScanRepositoryImpl({
    required this.service,
    required this.accessTokenGetter,
    required this.dao,
    required this.connectivityService
  });

  @override
  Future<IdCodeInfo> getInfoByIdBase(IdCodeInfo info) async {
    if( await connectivityService.thereIsConnectivity() ) {
      final accessToken = await accessTokenGetter.getAccessToken();
      final worker = await service.getInfoByIdentification(info.docNumber, accessToken);
      info = IdCodeInfo(
        docNumber: info.docNumber,
        worker: worker
      );
    }
    final data = WorkerMapper.toDb(info);
    await dao.insertWorker(data);
    return info;
  }
}