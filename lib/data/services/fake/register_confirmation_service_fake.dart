import 'dart:math';

import 'package:quadycons/domain/entities/attendance.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/data/services/register_confirmation_service.dart';

class RegisterConfirmationServiceFake implements RegisterConfirmationService {

  @override
  Future<Attendance> confirmCheckIn(Registration registration, String accessToken) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return Attendance(
      remoteId: Random().nextInt(99999999),
      idCodeInfo: registration.idCodeInfo,
      checkin: registration.check,
      checkout: null
    );
  }

  @override
  Future<Attendance> confirmCheckOut(Attendance attendance, String accessToken) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return attendance.copyWith(
      checkout: Check(
        time: DateTime.now(),
        location: attendance.checkin!.location
      )
    ); 
  }

}