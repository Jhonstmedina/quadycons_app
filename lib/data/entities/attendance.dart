import 'package:quadycons/data/entities/check.dart';
import 'package:quadycons/data/entities/id_code_info.dart';

class Attendance {
  final int? remoteId;
  final Check? checkin;
  final Check? checkout;
  final IdCodeInfo idCodeInfo;
  Attendance({
    this.remoteId,
    required this.checkin,
    required this.checkout,
    required this.idCodeInfo
  });
}