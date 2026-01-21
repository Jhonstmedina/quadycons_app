import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/mappers/attendance_mapper.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/repositories/synchronize_repository.dart';

class SynchronizeRepositoryImpl implements SynchronizeRepository {
  
  final AttendanceDao attendanceDao;

  SynchronizeRepositoryImpl({required this.attendanceDao});

  @override
  Future<List<PendingRegistration>> getPendingRegistrations() async {
    final pendingAttendances = await attendanceDao.getPending();
    return AttendanceMapper.pendingRegistrationsFromDb(pendingAttendances);
  }

  @override
  Future<void> synchronize() async {
    // TODO: implement synchronize
    throw UnimplementedError();
  }

}