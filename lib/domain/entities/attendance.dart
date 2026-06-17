import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';

class Attendance {
  final int? remoteId;
  final int? id;
  final Check? checkin;
  final Check? checkout;
  final IdCodeInfo idCodeInfo;
  Attendance({
    this.remoteId,
    this.id,
    required this.checkin,
    required this.checkout,
    required this.idCodeInfo
  });

  Attendance copyWith({
    int? remoteId,
    int? id,
    Check? checkin,
    Check? checkout,
    IdCodeInfo? idCodeInfo
  }) => Attendance(
    remoteId: remoteId ?? this.remoteId,
    id: id ?? this.id,
    checkin: checkin ?? this.checkin,
    checkout: checkout ?? this.checkout,
    idCodeInfo: idCodeInfo ?? this.idCodeInfo
  );
}