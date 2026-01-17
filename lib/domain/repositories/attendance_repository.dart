import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/registration.dart';

abstract class AttendanceRepository {
  Future<Attendance> confirmCheckIn(Registration registration);
  Future<Attendance> confirmCheckOut(Attendance attendance);
  Future<Attendance?> getAttendanceByUserDoc(String docNumber);
}