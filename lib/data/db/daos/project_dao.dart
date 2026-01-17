import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/projects_table.dart';

part 'project_dao.g.dart';

@DriftAccessor(tables: [Projects])
class ProjectsDao extends DatabaseAccessor<AppDatabase>
    with _$ProjectsDaoMixin {
  ProjectsDao(super.db);

  Future<int> insertProject(ProjectsCompanion data) {
    return into(projects).insert(data);
  }

  Future<void> updateProject(
    int id,
    ProjectsCompanion data,
  ) {
    return (update(projects)..where((p) => p.id.equals(id)))
        .write(data);
  }

  Future<List<Project>> getAll() {
    return select(projects).get();
  }

  Future<Project?> getById(int id) {
    return (select(projects)..where((p) => p.id.equals(id)))
        .getSingleOrNull();
  }
}