

import 'package:drift/drift.dart';
import 'package:quadycons/data/db/app_database.dart' as db;
import 'package:quadycons/data/db/dtos/attendance_with_worker.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/registration.dart';

class AttendanceMapper {
  static db.AttendancesCompanion toDb(Attendance a) {
    return db.AttendancesCompanion(
      idCodeDocNumber: Value(a.idCodeInfo.docNumber),
      remoteId: Value(a.remoteId),
      checkInDate: Value(a.checkin?.time),
      checkInLat: Value(a.checkin?.location.lat),
      checkInLon: Value(a.checkin?.location.lon),
      checkOutDate: Value(a.checkout?.time),
      checkOutLat: Value(a.checkout?.location.lat),
      checkOutLon: Value(a.checkout?.location.lon)
    );
  }

  static Attendance fromDbWithWorker(
    db.Attendance a,
    db.Worker w,
    List<Project> projects
  ) {
    return Attendance(
      id: a.id,
      remoteId: a.remoteId,
      idCodeInfo: IdCodeInfo(
        docNumber: w.docNumber,
        worker: Worker(
          id: w.id?.toString(),
          name: w.name,
          profileUrl: w.profileUrl,
          position: w.position,
          project: projects.firstWhere(
            (p) => p.id == w.projectId
          )
        ),
      ),
      checkin: a.checkInDate == null
          ? null
          : Check(
              time: a.checkInDate!,
              location: LatLng(
                lat: a.checkInLat!,
                lon: a.checkInLon!,
              ),
            ),
      checkout: a.checkOutDate == null
          ? null
          : Check(
              time: a.checkOutDate!,
              location: LatLng(
                lat: a.checkOutLat!,
                lon: a.checkOutLon!,
              ),
            ),
    );
  }

  static Attendance fromDb(db.Attendance row) {
    return Attendance(
      remoteId: row.remoteId,
      idCodeInfo: IdCodeInfo(
        docNumber: row.idCodeDocNumber,
      ),
      checkin: row.checkInDate == null
          ? null
          : Check(
              time: row.checkInDate!,
              location: LatLng(
                lat: row.checkInLat!,
                lon: row.checkInLon!,
              ),
            ),
      checkout: row.checkOutDate == null
          ? null
          : Check(
              time: row.checkOutDate!,
              location: LatLng(
                lat: row.checkOutLat!,
                lon: row.checkOutLon!,
              ),
            ),
    );
  }

  static List<PendingRegistration> getRegistrationsFromDb(List<AttendanceWithWorker> rows, List<Project> projects) {
    final pending = <PendingRegistration>[];
    for (final row in rows) {
      pending.add(PendingRegistration(
        attendanceLocalId: row.attendance.id,
        registration: Registration(
          check: Check(
            time: row.attendance.checkInDate!,
            location: LatLng(
              lat: row.attendance.checkInLat!,
              lon: row.attendance.checkInLon!
            )
          ),
          idCodeInfo: IdCodeInfo(
            docNumber: row.worker.docNumber,
            worker: Worker(
              id: row.worker.id?.toString(),
              name: row.worker.name,
              profileUrl: row.worker.profileUrl,
              position: row.worker.position,
              project: projects.firstWhere(
                (p) => p.id == row.worker.projectId
              )
            )
          ),
          type: .checkIn
        ),
        status: row.attendance.synced ? 
          .completed : 
          .pending
      ));
      if(row.attendance.checkOutDate != null) {
        pending.add(PendingRegistration(
          attendanceLocalId: row.attendance.id,
          attendanceRemoteId: row.attendance.remoteId,
          registration: Registration(
            check: Check(
              time: row.attendance.checkOutDate!,
              location: LatLng(
                lat: row.attendance.checkOutLat!,
                lon: row.attendance.checkOutLon!
              )
            ),
            idCodeInfo: IdCodeInfo(
              docNumber: row.worker.docNumber,
              worker: Worker(
                id: row.worker.id?.toString(),
                name: row.worker.name,
                profileUrl: row.worker.profileUrl,
                position: row.worker.position,
                project: projects.firstWhere(
                  (p) => p.id == row.worker.projectId
                )
              )
            ),
            type: .checkOut
          ),
          status: row.attendance.synced ? 
            .completed : 
            .pending
        ));
      }
    }
    return pending;
  }
}
