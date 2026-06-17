// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worker_dao.dart';

// ignore_for_file: type=lint
mixin _$WorkersDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProjectsTable get projects => attachedDatabase.projects;
  $WorkersTable get workers => attachedDatabase.workers;
  WorkersDaoManager get managers => WorkersDaoManager(this);
}

class WorkersDaoManager {
  final _$WorkersDaoMixin _db;
  WorkersDaoManager(this._db);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db.attachedDatabase, _db.projects);
  $$WorkersTableTableManager get workers =>
      $$WorkersTableTableManager(_db.attachedDatabase, _db.workers);
}
