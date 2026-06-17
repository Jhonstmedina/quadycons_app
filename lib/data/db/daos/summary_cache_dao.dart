import 'package:drift/drift.dart';
import 'package:quadycons/data/db/dtos/summary_dto.dart';
import '../app_database.dart';
import '../tables/summary_cache_table.dart';

part 'summary_cache_dao.g.dart';

@DriftAccessor(tables: [SummaryCache])
class SummaryCacheDao extends DatabaseAccessor<AppDatabase>
    with _$SummaryCacheDaoMixin {
  SummaryCacheDao(super.db);

  Future<SummaryDTO?> getCachedSummary(int projectId) async {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final result = await (select(summaryCache)
          ..where((s) => s.projectId.equals(projectId))
          ..where((s) => s.date.isBiggerOrEqualValue(todayStart)))
        .getSingleOrNull();
    if (result == null) return null;
    return SummaryDTO(
      inputs: result.inputs,
      outputs: result.outputs,
      pending: result.pending,
      absent: result.absent,
    );
  }

  Future<void> saveSummary(int projectId, SummaryDTO summary) async {
    await (delete(summaryCache)..where((s) => s.projectId.equals(projectId))).go();
    await into(summaryCache).insert(SummaryCacheCompanion(
      projectId: Value(projectId),
      inputs: Value(summary.inputs),
      outputs: Value(summary.outputs),
      pending: Value(summary.pending),
      absent: Value(summary.absent),
      date: Value(DateTime.now()),
    ));
  }

  Future<void> clearOldCache() async {
    final todayStart = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    await (delete(summaryCache)..where((s) => s.date.isSmallerThanValue(todayStart))).go();
  }
}