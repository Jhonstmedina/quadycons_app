import 'package:drift/drift.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/data/db/app_database.dart' as db;

class ProjectMapper {
  static Project fromDb(db.Project row) {
    return Project(
      id: row.id,
      name: row.name,
      geoLocation: LatLng(
        lat: row.latitude,
        lon: row.longitude,
      ),
      geoFence: row.geoFence,
    );
  }

  static db.ProjectsCompanion toDb(Project project) {
    return db.ProjectsCompanion(
      id: Value(project.id),
      name: Value(project.name),
      latitude: Value(project.geoLocation.lat),
      longitude: Value(project.geoLocation.lon),
      geoFence: Value(project.geoFence),
    );
  }
}
