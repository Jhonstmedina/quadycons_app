import 'package:quadycons/data/db/app_database.dart' as db;

class AttendanceWithWorker {
  final db.Attendance attendance;
  final db.Worker worker;

  AttendanceWithWorker({
    required this.attendance,
    required this.worker,
  });
}
