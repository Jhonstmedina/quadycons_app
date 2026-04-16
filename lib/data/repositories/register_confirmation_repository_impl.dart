import 'package:quadycons/core/repository_error_handler.dart';
import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/daos/summary_cache_dao.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import 'package:quadycons/data/db/mappers/attendance_mapper.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';
import 'package:quadycons/domain/repositories/attendance_repository.dart';
import 'package:quadycons/domain/exceptions.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final RegisterConfirmationService registerConfirmationService;
  final AccessTokenGetter accessTokenGetter;
  final AttendanceDao dao;
  final ConnectivityService connectivityService;
  final RepositoryErrorHandler errorHandler;
  final SummaryCacheDao summaryCacheDao;

  AttendanceRepositoryImpl({
    required this.registerConfirmationService,
    required this.accessTokenGetter,
    required this.dao,
    required this.connectivityService,
    required this.errorHandler,
    required this.summaryCacheDao
  });

  @override
  Future<Attendance> confirmCheckIn(Registration registration) async => await errorHandler.executeFunction(() async {
    late Attendance attendance;
    late int attendanceId;
    if( await connectivityService.thereIsConnectivity() ) {
      // CON INTERNET: servidor primero, local después
      final accessToken = await accessTokenGetter.getAccessToken();
      attendance = await registerConfirmationService.confirmCheckIn(
        registration,
        accessToken
      );
      attendanceId = await _insertAttendanceLocally(attendance);
      await dao.changeSynced(localId: attendanceId, synced: true);
    } else {
      // SIN INTERNET: validar duplicado local solo con registros no sincronizados
      final existingLocal = await dao.getUnsyncedByDocNumberToday(
        registration.idCodeInfo.docNumber
      );
      if (existingLocal != null && existingLocal.checkInDate != null) {
        throw GeneralException(message: 'Ya existe un registro de entrada local pendiente de sincronizar');
      }
      attendance = Attendance(
        checkin: registration.check,
        checkout: null,
        idCodeInfo: registration.idCodeInfo
      );
      attendanceId = await _insertAttendanceLocally(attendance);
    }
    attendance = attendance.copyWith(id: attendanceId);
    final projectId = registration.idCodeInfo.worker?.project?.id;
    if (projectId != null) {
      final cached = await summaryCacheDao.getCachedSummary(projectId);
      if (cached != null) {
        await summaryCacheDao.saveSummary(projectId, SummaryDTO(
          inputs: cached.inputs + 1,
          outputs: cached.outputs,
          pending: cached.pending,
          absent: cached.absent > 0 ? cached.absent - 1 : 0,
        ));
      }
    }
    return attendance;
  });

  Future<int> _insertAttendanceLocally(Attendance attendance) async {
    final data = AttendanceMapper.toDb(attendance);
    return await dao.insertAttendance(data);
  }

  @override
  Future<Attendance> confirmCheckOut(Attendance attendance) async => await errorHandler.executeFunction(() async {
    if( await connectivityService.thereIsConnectivity() ) {
      final accessToken = await accessTokenGetter.getAccessToken();
      attendance = await registerConfirmationService.confirmCheckOut(
        attendance,
        accessToken
      );
      await _updateAttendanceLocally(attendance);
      await dao.changeSynced(localId: attendance.id!, synced: true);
    } else {
      await _updateAttendanceLocally(attendance);
    }
    final projectId = attendance.idCodeInfo.worker?.project?.id;
    if (projectId != null) {
      final cached = await summaryCacheDao.getCachedSummary(projectId);
      if (cached != null) {
        await summaryCacheDao.saveSummary(projectId, SummaryDTO(
          inputs: cached.inputs,
          outputs: cached.outputs + 1,
          pending: cached.pending > 0 ? cached.pending - 1 : 0,
          absent: cached.absent,
        ));
      }
    }
    return attendance;
  });

  Future<void> _updateAttendanceLocally(Attendance attendance) async {
    final data = AttendanceMapper.toDb(attendance);
    await dao.updateAttendance(attendance.id!, data);
  }
  
  @override
  Future<Attendance?> getAttendanceByUserDoc(String docNumber, List<Project> projects) async {
    final data = await dao.getByUserDocWithWorker(docNumber);
    if (data == null) {
      return null;
    }
    return AttendanceMapper.fromDbWithWorker(data.attendance, data.worker, projects);
  }
}