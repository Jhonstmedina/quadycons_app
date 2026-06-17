import 'package:quadycons/core/repository_error_handler.dart';
import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/daos/summary_cache_dao.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/summary_service.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/repositories/summary_repository.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  final AttendanceDao attendanceDao;
  final SummaryCacheDao summaryCacheDao;
  final SummaryService summaryService;
  final AccessTokenGetter accessTokenGetter;
  final ConnectivityService connectivityService;
  final RepositoryErrorHandler errorHandler;

  SummaryRepositoryImpl({
    required this.attendanceDao,
    required this.summaryCacheDao,
    required this.summaryService,
    required this.accessTokenGetter,
    required this.connectivityService,
    required this.errorHandler,
  });

  @override
  Future<SummaryDTO> getSummary(int projectId) async {
    // Primero limpiar cache viejo
    await summaryCacheDao.clearOldCache();
    // Buscar cache de hoy
    final cached = await summaryCacheDao.getCachedSummary(projectId);
    if (cached != null) {
      return cached;
    }
    // Si no hay cache, usar datos locales
    return await attendanceDao.getSummaryByProject(projectId);
  }

  @override
  Future<SummaryDTO> getRemoteSummary(int projectId) async {
    return await errorHandler.executeFunction(() async {
      final accessToken = await accessTokenGetter.getAccessToken();
      final summary = await summaryService.getSummaryToday(accessToken, projectId);
      // Guardar en cache local
      await summaryCacheDao.saveSummary(projectId, summary);
      return summary;
    });
  }
}