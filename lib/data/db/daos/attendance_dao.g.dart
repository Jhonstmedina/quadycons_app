// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_dao.dart';

// ignore_for_file: type=lint
mixin _$AttendanceDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $WorkersTable get workers => attachedDatabase.workers;
  $AttendancesTable get attendances => attachedDatabase.attendances;
  AttendanceDaoManager get managers => AttendanceDaoManager(this);
}

class AttendanceDaoManager {
  final _$AttendanceDaoMixin _db;
  AttendanceDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$WorkersTableTableManager get workers =>
      $$WorkersTableTableManager(_db.attachedDatabase, _db.workers);
  $$AttendancesTableTableManager get attendances =>
      $$AttendancesTableTableManager(_db.attachedDatabase, _db.attendances);
}
