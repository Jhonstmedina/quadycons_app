import 'dart:convert';

import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/project.dart';

class CodeScanAdapter {
  static const _invalidNameTokens = {
    'MASCULINO',
    'FEMENINO',
    'NO',
    'SI',
    'ENCONTRADAS',
    'MINUCIAS',
  };

  final _nameRegex = RegExp(r'^[A-ZÁÉÍÓÚÑ]{2,}$');


  IdCodeInfo? getInfoByCode(String? code) {
    //TODO: Quitar cuando se deje de probar
    return IdCodeInfo(
      docNumber: '112132421Q',
      worker: Worker(
        id: null,
        name: 'Jean Clau Vandame',
        profileUrl: null,
        position: 'Portero',
        project: null
      )
    );
    print('************************* \n $code');
    if(code == null){
      return null;
    }
    final value = code.trim();

    // 1️⃣ QR SIMPLE (solo número)
    if (!_containsDelimiter(value)) {
      return _getCodeInfoFromJson(code);
    }

    // 2️⃣ CÉDULA PARAGUAY (datos estructurados)
    final parts = _splitCode(value);

    // Seguridad mínima
    if (parts.length < 3) {
      return IdCodeInfo(
        docNumber: parts.first,
        worker: null,
      );
    }

    final idDocument = parts[1];
    final possibleName = parts[4];
    String? nameEnd;
    if(_isNameToken(possibleName)) {
      nameEnd = possibleName;
    }
    final name = '${parts[2]} ${parts[3]}${nameEnd != null ? ' $nameEnd' : ''}'.trim();

    final worker = Worker(
      id: null,
      name: name,
      position: null,
      profileUrl: null,
      project: null
    );

    return IdCodeInfo(
      docNumber: idDocument,
      worker: worker
    );
  }

  bool _containsDelimiter(String value) {
    return value.contains('|') || value.contains(';') || value.contains('>') || value.contains('<');
  }

  IdCodeInfo _getCodeInfoFromJson(String code) {
    final json = jsonDecode(code);
    final projectId = json['proyecto_id'];
    final project = projectId != null
      ? Project(
          id: json['proyecto_id'],
          name: json['proyecto'],
          geoLocation: null,
          geoFence: null
        )
      : null;
    return IdCodeInfo(
      docNumber: json['cedula'],
      worker: Worker(
        id: null,
        name: json['nombre'],
        position: json['cargo'],
        profileUrl: null,
        project: project
      )
    );
  }

  List<String> _splitCode(String value) {
    if (value.contains('|')) {
      return value.split('|');
    }
    if (value.contains(';')) {
      return value.split(';');
    }
    if(value.contains('>')) {
      return value.split('>');
    }
    if(value.contains('<')) {
      return value.split('<');
    }
    return [value];
  }

  bool _isNameToken(String value) {
    if (!_nameRegex.hasMatch(value)) return false;
    if (_invalidNameTokens.contains(value)) return false;
    return true;
  }
}