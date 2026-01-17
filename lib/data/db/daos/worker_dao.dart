import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/workers_table.dart';

part 'worker_dao.g.dart';

@DriftAccessor(tables: [Workers])
class WorkersDao extends DatabaseAccessor<AppDatabase>
    with _$WorkersDaoMixin {
  WorkersDao(super.db);

  Future<int> insertWorker(WorkersCompanion data) {
    return into(workers).insert(data);
  }

  Future<void> updateWorker(
    String docNumber,
    WorkersCompanion data,
  ) {
    return (update(workers)
          ..where((w) => w.docNumber.equals(docNumber)))
        .write(data);
  }

  Future<Worker?> getByDocNumber(String docNumber) {
    return (select(workers)
          ..where((w) => w.docNumber.equals(docNumber)))
        .getSingleOrNull();
  }

  Future<List<Worker>> getByProject(int projectId) {
    return (select(workers)
          ..where((w) => w.projectId.equals(projectId)))
        .get();
  }
}
