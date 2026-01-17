import 'package:quadycons/data/entities/attendance.dart';
import 'package:quadycons/data/entities/registration.dart';

abstract class AttendanceRepository {
  Future<Attendance> confirmRegistration(Attendance registration);
  Future<Attendance> confirmCheckIn(Registration registration);
  Future<Attendance> confirmCheckOut(Attendance attendance);
  Future<Attendance?> getAttendanceByUserDoc(String docNumber);
}