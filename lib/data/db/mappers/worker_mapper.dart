import 'package:quadycons/data/db/app_database.dart' as db;
import 'package:drift/drift.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';

class WorkerMapper {
  static IdCodeInfo fromDb(db.Worker row) {
    return IdCodeInfo(
      worker: Worker(
        id: row.id,
        name: row.name,
        profileUrl: row.profileUrl,
        position: row.position,
        projectId: row.projectId
      ),
      docNumber: row.docNumber
    );
  }

  static db.WorkersCompanion toDb(IdCodeInfo idCodeInfo) {
    return db.WorkersCompanion(
      name: Value(idCodeInfo.worker!.name),
      profileUrl: Value(idCodeInfo.worker!.profileUrl),
      position: Value(idCodeInfo.worker!.position),
      docNumber: Value(idCodeInfo.docNumber),
      projectId: Value(idCodeInfo.worker!.projectId)
    );
  }
}