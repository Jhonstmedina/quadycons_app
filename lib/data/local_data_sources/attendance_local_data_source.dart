import 'package:flutter/material.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';

abstract class AttendanceLocalDataSource {
  Future<void> saveAttendance(Attendance attendance);
  Future<Attendance?> getAttendanceByUserDoc(String docNumber);
}

class AttendanceLocalDataSourceImpl implements AttendanceLocalDataSource {
  @override
  Future<void> saveAttendance(Attendance attendance) async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<Attendance?> getAttendanceByUserDoc(String docNumber) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return null;
    /*
    return Attendance(
      checkin: Check(
        time: TimeOfDay(
          hour: TimeOfDay.now().hour - 1,
          minute: TimeOfDay.now().minute - 1
        ),
        location: LatLng(lat: 0, lon: 0)
      ),
      checkout: null,
      idCodeInfo: IdCodeInfo(
        docNumber: docNumber,
        worker: Worker(
          id: null,
          name: 'Carlos Parra',
          profileUrl: null,
          position: null,
          projectId: 1
        )
      )
    );
    */
  }
}