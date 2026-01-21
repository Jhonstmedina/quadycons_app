

import 'package:drift/drift.dart';
import 'package:quadycons/data/db/app_database.dart' as db;
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/pending_registration.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/domain/entities/registration_status.dart';

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
          projectId: w.projectId,
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

  static List<PendingRegistration> pendingRegistrationsFromDb(List<db.Attendance> rows) {
    final pending = <PendingRegistration>[];
    for (final row in rows) {
      if(row.remoteId == null) {
        pending.add(PendingRegistration(
          attendanceLocalId: row.id,
          registration: Registration(
            check: Check(
              time: row.checkInDate!,
              location: LatLng(
                lat: row.checkInLat!,
                lon: row.checkInLon!
              )
            ),
            idCodeInfo: IdCodeInfo(docNumber: row.idCodeDocNumber),
            type: RegisterType.checkIn
          ),
          status: RegistrationStatus.pending
        ));
      }
      if(row.checkOutDate != null && !row.synced) {
        pending.add(PendingRegistration(
          attendanceLocalId: row.id,
          attendanceRemoteId: row.remoteId,
          registration: Registration(
            check: Check(
              time: row.checkOutDate!,
              location: LatLng(
                lat: row.checkOutLat!,
                lon: row.checkOutLon!
              )
            ),
            idCodeInfo: IdCodeInfo(docNumber: row.idCodeDocNumber),
            type: RegisterType.checkOut
          ),
          status: RegistrationStatus.pending
        ));
      }
    }
    return pending;
  }
}
