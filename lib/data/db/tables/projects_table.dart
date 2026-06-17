import 'package:drift/drift.dart';

class Projects extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();

  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  RealColumn get geoFence => real().nullable()();

  BoolColumn get synced =>
      boolean().withDefault(const Constant(false))();
}