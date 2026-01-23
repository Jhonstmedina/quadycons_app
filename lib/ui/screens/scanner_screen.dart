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
    formats: [
      BarcodeFormat.qrCode,
      BarcodeFormat.pdf417,
      BarcodeFormat.code128
    ],
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
          final rawValue = barcode.rawValue;
          final idInfo = scanAdapter.getInfoByCode(rawValue);
          
          if (idInfo != null) {
            scanned = true;
            controller.stop();

            debugPrint('Código detectado:');
            debugPrint(rawValue);

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
