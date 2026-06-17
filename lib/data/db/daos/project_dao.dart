import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/projects_table.dart';

part 'project_dao.g.dart';

@DriftAccessor(tables: [Projects])
class ProjectsDao extends DatabaseAccessor<AppDatabase>
    with _$ProjectsDaoMixin {
  ProjectsDao(super.db);
  
  Future<void> insertProjects(List<ProjectsCompanion> list) {
    return batch((b) {
      b.insertAll(
        projects,
        list,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<List<Project>> getAll() {
    return select(projects).get();
  }
}