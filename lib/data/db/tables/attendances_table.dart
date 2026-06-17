import 'package:drift/drift.dart';
import 'package:quadycons/data/db/tables/workers_table.dart';

class Attendances extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteId => integer().nullable()();

  TextColumn get idCodeDocNumber =>
      text().references(Workers, #docNumber)();

  DateTimeColumn get checkInDate => dateTime().nullable()();
  RealColumn get checkInLat => real().nullable()();
  RealColumn get checkInLon => real().nullable()();

  DateTimeColumn get checkOutDate => dateTime().nullable()();
  RealColumn get checkOutLat => real().nullable()();
  RealColumn get checkOutLon => real().nullable()();

  BoolColumn get synced =>
      boolean().withDefault(const Constant(false))();
}