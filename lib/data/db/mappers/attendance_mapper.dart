

import 'package:drift/drift.dart';
import 'package:quadycons/data/db/app_database.dart' as db;
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';

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
}
