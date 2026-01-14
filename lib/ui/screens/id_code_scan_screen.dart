import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/data/entities/id_code_info.dart';
import 'package:quadycons/data/entities/register_type.dart';
import 'package:quadycons/data/entities/registration.dart';
import 'package:quadycons/domain/blocs/code_scan/code_scan_bloc.dart';
import 'package:quadycons/injection_container.dart';
import 'package:quadycons/ui/screens/register_confirmation_screen.dart';
import 'package:quadycons/ui/screens/scanner_screen.dart';
import 'package:quadycons/ui/widgets/scan_button.dart';
import 'package:quadycons/ui/widgets/radio_scan_button.dart';

class IdCodeScanScreen extends StatelessWidget {
  const IdCodeScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<CodeScanBloc>(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            child: BlocConsumer<CodeScanBloc, CodeScanState>(
              listener: (context, state){
                if((state as Registrating).errorMessage != null){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                      backgroundColor: Colors.red
                    )
                  );
                } if (state.registerType != null && state.idDocInfo != null && (state.isInFence??false)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterConfirmationScreen(),
                      settings: RouteSettings(
                        arguments: Registration(
                          checkInTime: state.registerType == RegisterType.entry?
                            TimeOfDay.now(): null,
                          checkOutTime: state.registerType == RegisterType.exit?
                            TimeOfDay.now(): null,
                          idCodeInfo: state.idDocInfo!
                        )
                      )
                    )
                  );
                }
              },
              builder: (context, state) {
                state = state as Registrating;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Escaneo de cédula / QR',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20
                          )
                        ),
                        Chip(
                          label: Text(
                            'offline solo',
                            style: TextStyle(
                              fontSize: 12
                            )
                          ),
                          backgroundColor: Colors.green,
                          labelStyle: TextStyle(color: Colors.white),
                          labelPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          )
                        )
                      ]
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F3FF),
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_scanner,
                            size: 80,
                            weight: 700
                          ),
                          SizedBox(height: 16),
                          Text(
                            'apunta al código de barras de la cédula o al QR',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14
                            ),
                            textAlign: TextAlign.center
                          ),
                          SizedBox(height: 16),
                          if(state.idDocInfo != null)
                            Text(
                              state.idDocInfo!.docNumber,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                              )
                            ),
                          TextButton(
                            onPressed: () async {
                              _scan(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.black
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Abrir cámara',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16
                                  )
                                )
                              ]
                            )
                          )
                        ]
                      )
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ScanRegistrationButton(
                          icon: Icons.login,
                          text: 'Entrada',
                          registerType: RegisterType.entry
                        ),
                        ScanRegistrationButton(
                          icon: Icons.logout,
                          text: 'Salida',
                          registerType: RegisterType.exit
                        ),
                        ScanButton(
                          icon: Icons.refresh,
                          text: 'Reintentar',
                          onPressed: () {
                            _scan(context);
                          }
                        )
                      ]
                    )
                  ]
                );
              }
            )
          )
        )
      )
    );
  }

  Future<void> _scan(BuildContext context) async {
    final idCodeInfo = await Navigator.push<IdCodeInfo?>(
      context,
      MaterialPageRoute(
        builder: (context) => ScannerScreen()
      )
    );
    BlocProvider.of<CodeScanBloc>(context).add(
      InsertScanInfo(idCodeInfo)
    );
  }
}
