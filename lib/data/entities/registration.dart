import 'package:quadycons/data/entities/check.dart';
import 'package:quadycons/data/entities/id_code_info.dart';
import 'package:quadycons/data/entities/register_type.dart';

class Registration {
  final Check check;
  final IdCodeInfo idCodeInfo;
  final RegisterType type;
  Registration({
    required this.check,
    required this.idCodeInfo,
    required this.type
  });
}