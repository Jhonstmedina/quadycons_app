import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/register_type.dart';

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