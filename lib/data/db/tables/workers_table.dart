import 'package:drift/drift.dart';
import 'projects_table.dart';

class Workers extends Table {
  TextColumn get id => text().nullable()(); // remote id
  TextColumn get name => text()();
  TextColumn get profileUrl => text().nullable()();
  TextColumn get position => text().nullable()();
  TextColumn get docNumber => text()();

  IntColumn get projectId =>
      integer().references(Projects, #id)();
}