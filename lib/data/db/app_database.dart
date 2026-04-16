import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

import 'tables/projects_table.dart';
import 'tables/workers_table.dart';
import 'tables/attendances_table.dart';
import 'tables/summary_cache_table.dart';
import 'package:sqflite/sqflite.dart';

part 'app_database.g.dart';

abstract class DataBaseCleaner {
  Future<void> clearDatabase();
}

@DriftDatabase(
  tables: [
    Projects,
    Workers,
    Attendances,
    SummaryCache,
  ],
)
class AppDatabase extends _$AppDatabase implements DataBaseCleaner {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(summaryCache);
      }
    },
  );

  @override
  Future<void> clearDatabase() async {
    await transaction(() async {
      await delete(attendances).go();
      await delete(workers).go();
      await delete(projects).go();
      await delete(summaryCache).go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getDatabasesPath();
    final file = File(p.join(dbFolder, 'app_database.db'));
    return NativeDatabase(file);
  });
}
