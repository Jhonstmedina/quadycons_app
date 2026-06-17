import 'package:drift/drift.dart';

class SummaryCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get projectId => integer()();
  IntColumn get inputs => integer()();
  IntColumn get outputs => integer()();
  IntColumn get pending => integer()();
  IntColumn get absent => integer()();
  DateTimeColumn get date => dateTime()();
}