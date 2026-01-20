import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/mappers/attendance_mapper.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/data/local_data_source/access_token_getter.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';
import 'package:quadycons/domain/repositories/attendance_repository.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final RegisterConfirmationService registerConfirmationService;
  final AccessTokenGetter accessTokenGetter;
  final AttendanceDao dao;

  AttendanceRepositoryImpl({
    required this.registerConfirmationService,
    required this.accessTokenGetter,
    required this.dao
  });

  @override
  Future<Attendance> confirmCheckIn(Registration registration) async {
    final accessToken = await accessTokenGetter.getAccessToken();
    Attendance attendance = await registerConfirmationService.confirmCheckIn(
      registration,
      accessToken
    );
    final data = AttendanceMapper.toDb(attendance);
    final id = await dao.insertAttendance(data);
    await dao.changeSynced(localId: id, synced: true);
    attendance = attendance.copyWith(id: id);
    return attendance;
  }

  @override
  Future<Attendance> confirmCheckOut(Attendance attendance) async {
    final accessToken = await accessTokenGetter.getAccessToken();
    attendance = await registerConfirmationService.confirmCheckOut(
      attendance,
      accessToken
    );
    final data = AttendanceMapper.toDb(attendance);
    await dao.updateAttendance(attendance.id!, data);
    await dao.changeSynced(localId: attendance.id!, synced: true);
    return attendance;
  }
  
  @override
  Future<Attendance?> getAttendanceByUserDoc(String docNumber) async {
    final data = await dao.getByUserDocWithWorker(docNumber);
    if (data == null) {
      return null;
    }
    return AttendanceMapper.fromDbWithWorker(data.attendance, data.worker);
  }
}