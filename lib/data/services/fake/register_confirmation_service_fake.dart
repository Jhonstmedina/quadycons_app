import 'package:flutter/material.dart';
import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';

class RegisterConfirmationServiceFake implements RegisterConfirmationService {
  @override
  Future<Attendance> confirmRegistration(Attendance registration, String accessToken) async {
    await Future.delayed(const Duration(seconds: 1));
    return registration;
  }

  @override
  Future<Attendance> confirmCheckIn(Registration registration, String accessToken) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return Attendance(
      idCodeInfo: registration.idCodeInfo,
      checkin: registration.check,
      checkout: null,
    );
  }

  @override
  Future<Attendance> confirmCheckOut(Attendance attendance, String accessToken) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return Attendance(
      idCodeInfo: attendance.idCodeInfo,
      checkin: attendance.checkin,
      checkout: Check(
        time: DateTime.now(),
        location: attendance.checkin!.location
      )
    );
  }

}