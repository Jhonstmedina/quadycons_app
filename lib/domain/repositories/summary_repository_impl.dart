import 'package:quadycons/core/repository_error_handler.dart';
import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/summary_service.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/repositories/summary_repository.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  final AttendanceDao attendanceDao;
  final SummaryService summaryService;
  final AccessTokenGetter accessTokenGetter;
  final ConnectivityService connectivityService;
  final RepositoryErrorHandler errorHandler;

  SummaryRepositoryImpl({
    required this.attendanceDao,
    required this.summaryService,
    required this.accessTokenGetter,
    required this.connectivityService,
    required this.errorHandler,
  });

  @override
  Future<SummaryDTO> getSummary(int projectId) async {
    return await attendanceDao.getSummaryByProject(projectId);
  }

  @override
  Future<SummaryDTO> getRemoteSummary(int projectId) async {
    return await errorHandler.executeFunction(() async {
      final accessToken = await accessTokenGetter.getAccessToken();
      return await summaryService.getSummaryToday(accessToken, projectId);
    });
  }
}