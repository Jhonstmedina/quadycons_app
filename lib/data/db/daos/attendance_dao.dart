import 'package:drift/drift.dart';
import 'package:quadycons/data/db/dtos/attendance_with_worker.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import 'package:quadycons/data/db/tables/attendances_table.dart';
import '../app_database.dart';

part 'attendance_dao.g.dart';

@DriftAccessor(tables: [Attendances])
class AttendanceDao extends DatabaseAccessor<AppDatabase>
    with _$AttendanceDaoMixin {
  AttendanceDao(super.db);

  Future<AttendanceWithWorker?> getByUserDocWithWorker(String userDoc) {
    final query = select(attendances).join([
      innerJoin(
        workers,
        workers.docNumber.equalsExp(attendances.idCodeDocNumber),
      ),
    ])..where(attendances.idCodeDocNumber.equals(userDoc))
      ..orderBy([
      OrderingTerm.desc(attendances.checkInDate),
    ])
    ..limit(1);

    return query.map((row) {
      return AttendanceWithWorker(
        attendance: row.readTable(attendances),
        worker: row.readTable(workers),
      );
    }).getSingleOrNull();
  }

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

  Future<SummaryDTO> getSummaryByProject(int projectId) async {
    final result = await customSelect(
      '''
      SELECT
      COALESCE(
        SUM(CASE WHEN a.check_in_date IS NOT NULL THEN 1 ELSE 0 END),
        0
      ) AS inputs,
      COALESCE(
        SUM(CASE WHEN a.check_out_date IS NOT NULL THEN 1 ELSE 0 END),
        0
      ) AS outputs,
      COALESCE(
        SUM(
          CASE
            WHEN
              (a.check_in_date IS NOT NULL AND a.remote_id IS NULL)
              OR
              (a.check_out_date IS NOT NULL AND a.synced = 0)
            THEN 1
            ELSE 0
          END
        ),
        0
      ) AS pending
    FROM attendances a
    WHERE EXISTS (
      SELECT 1
      FROM workers w
      WHERE w.doc_number = a.id_code_doc_number
        AND w.project_id = ?
    );
    ''',
      variables: [
        Variable.withInt(projectId),
      ],
    ).getSingle();
    //Para testear cuántos checkins y checkouts hay

    return SummaryDTO(
      inputs: result.read<int>('inputs'),
      outputs: result.read<int>('outputs'),
      pending: result.read<int>('pending')
    );
  }

}
