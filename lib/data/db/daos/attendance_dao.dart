import 'package:drift/drift.dart';
import 'package:quadycons/data/db/tables/attendances_table.dart';
import '../app_database.dart';

part 'attendance_dao.g.dart';

@DriftAccessor(tables: [Attendances])
class AttendanceDao extends DatabaseAccessor<AppDatabase>
    with _$AttendanceDaoMixin {
  AttendanceDao(super.db);

  Future<int> insertAttendance(AttendancesCompanion data) {
    return into(attendances).insert(data);
  }

  Future<void> updateAttendance(
    int id,
    AttendancesCompanion data,
  ) {
    return (update(attendances)
          ..where((a) => a.id.equals(id)))
        .write(data);
  }

  Future<List<Attendance>> getPending() {
    return (select(attendances)
          ..where((a) => a.synced.equals(false)))
        .get();
  }

  Future<Attendance?> getByUserDoc(String userDoc) {
    return (select(attendances)
          ..where((a) => a.idCodeDocNumber.equals(userDoc)))
        .getSingleOrNull();
  }

  Future<void> changeSynced({
    required int localId,
    required bool synced
  }) {
    return (update(attendances)
          ..where((a) => a.id.equals(localId)))
        .write(
          AttendancesCompanion(
            synced: Value(synced)
          )
        );
  }
}
