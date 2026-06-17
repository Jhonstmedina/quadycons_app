import 'package:drift/drift.dart';
import 'projects_table.dart';

class Workers extends Table {
  IntColumn get id => integer().nullable()();
  TextColumn get name => text()();
  TextColumn get profileUrl => text().nullable()();
  TextColumn get position => text().nullable()();
  TextColumn get docNumber => text()();

  IntColumn get projectId =>
      integer().references(Projects, #id)();
  
  @override
  List<String> get customConstraints => [
    'UNIQUE(doc_number, project_id)'
  ];
}