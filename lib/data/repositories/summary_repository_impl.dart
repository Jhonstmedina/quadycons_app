import 'package:quadycons/data/db/daos/attendance_dao.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import 'package:quadycons/domain/repositories/summary_repository.dart';

class SummaryRepositoryImpl implements SummaryRepository {
  final AttendanceDao attendanceDao;

  SummaryRepositoryImpl({required this.attendanceDao});

  @override
  Future<SummaryDTO> getSummary(int projectId) async {
    return await attendanceDao.getSummaryByProject(projectId);
  }
}