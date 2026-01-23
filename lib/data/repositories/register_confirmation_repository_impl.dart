import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/mappers/attendance_mapper.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';
import 'package:quadycons/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final RegisterConfirmationService registerConfirmationService;
  final AccessTokenGetter accessTokenGetter;
  final AttendanceDao dao;
  final ConnectivityService connectivityService;

  AttendanceRepositoryImpl({
    required this.registerConfirmationService,
    required this.accessTokenGetter,
    required this.dao,
    required this.connectivityService
  });

  @override
  Future<Attendance> confirmCheckIn(Registration registration) async {
    late Attendance attendance;
    late int attendanceId;
    if( await connectivityService.thereIsConnectivity() ) {
      final accessToken = await accessTokenGetter.getAccessToken();
      attendance = await registerConfirmationService.confirmCheckIn(
        registration,
        accessToken
      );
      attendanceId = await _insertAttendanceLocally(attendance);
      await dao.changeSynced(localId: attendanceId, synced: true);
    } else {
      attendance = Attendance(
        checkin: registration.check,
        checkout: null,
        idCodeInfo: registration.idCodeInfo
      );
      attendanceId = await _insertAttendanceLocally(attendance);
    }
    attendance = attendance.copyWith(id: attendanceId);
    return attendance;
  }

  Future<int> _insertAttendanceLocally(Attendance attendance) async {
    final data = AttendanceMapper.toDb(attendance);
    return await dao.insertAttendance(data);
  }

  @override
  Future<Attendance> confirmCheckOut(Attendance attendance) async {
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
    return attendance;
  }

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