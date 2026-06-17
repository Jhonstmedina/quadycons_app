import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quadycons/injection_container.dart';
import 'package:quadycons/core/adapters/code_scan_adapter.dart';

class ScannerScreen extends StatefulWidget {
  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController(
    /*
    Volver a poner en caso de que se necesite filtrar formatos
    formats: [
      BarcodeFormat.qrCode,
      BarcodeFormat.pdf417,
      BarcodeFormat.code128
    ],
    */
  );
  String? codeError;

  bool scanned = false;

  @override
  Widget build(BuildContext context) {
    final scanAdapter = sl<CodeScanAdapter>();
    return Scaffold(
      appBar: AppBar(title: const Text('Escanear documento')),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          if (scanned) return;

          final barcode = capture.barcodes.first;
          final value = barcode.rawValue ?? barcode.displayValue;

          if (value == null || value.isEmpty) return;

          final idInfo = scanAdapter.getInfoByCode(value);
          
          if (idInfo != null) {
            scanned = true;
            controller.stop();

            debugPrint('Código detectado:');
            debugPrint(value);

            // Aquí procesas el contenido
            Navigator.pop(context, idInfo);
          }
        }
      )
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
