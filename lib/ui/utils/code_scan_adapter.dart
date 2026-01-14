import 'package:quadycons/data/entities/id_code_info.dart';

class CodeScanAdapter {
  IdCodeInfo? getInfoByCode(String? code) {
    print('************************* \n $code');
    if(code == null){
      return null;
    }
    final value = code.trim();

    // 1️⃣ QR SIMPLE (solo número)
    if (!_containsDelimiter(value)) {
      return IdCodeInfo(
        docNumber: value,
        worker: null,
      );
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
    final name = '${parts[2]} ${parts[3]}';

    final worker = Worker(
      id: null,
      name: name,
      position: null,
      profileUrl: null
    );

    return IdCodeInfo(
      docNumber: idDocument,
      worker: worker
    );
  }

  bool _containsDelimiter(String value) {
    return value.contains('|') || value.contains(';');
  }

  List<String> _splitCode(String value) {
    if (value.contains('|')) {
      return value.split('|');
    }
    if (value.contains(';')) {
      return value.split(';');
    }
    return [value];
  }
}