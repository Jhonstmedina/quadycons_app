import 'package:drift/drift.dart';

class Projects extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();

  RealColumn get latitude => real()();
  RealColumn get longitude => real()();

  RealColumn get geoFence => real()();

  BoolColumn get synced =>
      boolean().withDefault(const Constant(false))();
}