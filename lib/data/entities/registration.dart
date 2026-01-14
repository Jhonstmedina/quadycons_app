import 'package:flutter/material.dart';
import 'package:quadycons/data/entities/id_code_info.dart';

class Registration {
  final TimeOfDay? checkInTime;
  final TimeOfDay? checkOutTime;
  final IdCodeInfo idCodeInfo;
  Registration({
    required this.checkInTime,
    required this.checkOutTime,
    required this.idCodeInfo
  });
}