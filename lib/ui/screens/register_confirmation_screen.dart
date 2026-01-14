import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/data/entities/registration.dart';
import 'package:quadycons/domain/blocs/register_confirmation/register_confirmation_bloc.dart';
import 'package:quadycons/injection_container.dart';
import 'package:quadycons/ui/screens/id_code_scan_screen.dart';
import 'package:quadycons/ui/widgets/register_time.dart';

class RegisterConfirmationScreen extends StatelessWidget {

  const RegisterConfirmationScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final registration = ModalRoute.of(context)!.settings.arguments as Registration;
    return Scaffold(
      body: BlocProvider<RegisterConfirmationBloc>(
        create: (context) => sl<RegisterConfirmationBloc>()
          ..add(InitRegistrationConfirmation(
            registration: registration
          )),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            child: BlocConsumer<RegisterConfirmationBloc, RegisterConfirmationState>(
              listener: (blocContext, state) {
                
              },
              builder: (context, state) {
                if(state is RegisterConfirmationInitial) {
                  return Center(
                    child: CircularProgressIndicator()
                  );
                }
                final registration = (state as OnRegistration).registration;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    // Título
                    Text(
                      state.confirmed ? 'Confirmación' : 'Resultado de escaneo',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24
                      )
                    ),
                    const SizedBox(height: 6),
                    
                    // Row con check y mensaje de éxito
                    if(state.confirmed)
                      ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.black,
                              size: 30
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Asistencia guardada con éxito',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                  )
                                ),
                                Text(
                                  'Proyecto: Torre Norte ${_timeOfDayToString(registration.checkInTime)}${registration.checkOutTime != null ? ' - ${_timeOfDayToString(registration.checkOutTime)}' : ''}',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14
                                  )
                                )
                              ]
                            )
                          ]
                        ),
                        const SizedBox(height: 24)
                      ],
                    
                    // Row con avatar y datos del usuario
                    Row(
                      children: [
                        // Avatar circular
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.075,
                          backgroundColor: Colors.grey[300],
                          child: registration.idCodeInfo.worker?.profileUrl != null?
                            ClipOval(
                              child: Image.network(
                                registration.idCodeInfo.worker!.profileUrl!,
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: MediaQuery.of(context).size.width * 0.15,
                                fit: BoxFit.cover,
                              )
                            ): Icon(
                              Icons.person,
                              size: MediaQuery.of(context).size.width * 0.1,
                              color: Colors.white
                            )
                        ),
                        const SizedBox(width: 16),
                        // Columna con nombre y descripción
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              registration.idCodeInfo.worker?.name ?? 'Nombre no disponible',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              )
                            ),
                            Text(
                              '${registration.idCodeInfo.worker?.position ?? 'Posición no disponible'} - Cédula ${registration.idCodeInfo.docNumber}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14
                              )
                            )
                          ]
                        )
                      ]
                    ),
                    const SizedBox(height: 24),
                    
                    // Row con badges de registro y ubicación
                    if(!state.confirmed)
                      ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Badge de registro
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F3FF),
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    registration.checkInTime != null ?
                                      Icons.login :
                                      Icons.logout,
                                    size: 18
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Registro: ${registration.checkInTime != null? "Entrada": "Salida"}',
                                    style: TextStyle(fontSize: 14)
                                  )
                                ]
                              )
                            ),
                            // Badge de ubicación
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(
                                'Dentro de ubicación',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                                )
                              )
                            )
                          ]
                        ),
                        const SizedBox(height: 24)
                      ],
                    
                    // Row con dos TextFields
                    Row(
                      children: [
                        Expanded(
                          child: RegisterTime(
                            title: 'Hora de entrada',
                            text: _timeOfDayToString(registration.checkInTime)
                          )
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: RegisterTime(
                            title: 'Hora de salida',
                            text: _timeOfDayToString(registration.checkOutTime)
                          )
                        )
                      ]
                    ),
                    const SizedBox(height: 24),
                    
                    // Botón confirmar
                    ElevatedButton(
                      onPressed: () {
                        if(state.confirmed) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IdCodeScanScreen()
                            )
                          );
                        } else {
                          context.read<RegisterConfirmationBloc>().add(ConfirmRegistration());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.confirmed ?
                          Color(0xFFF5F3FF) :
                          Colors.blue[700],
                        foregroundColor: state.confirmed ?
                          Colors.black :
                          Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        minimumSize: Size(double.infinity, 0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(state.confirmed ? Icons.crop_free : Icons.check),
                          const SizedBox(width: 8),
                          Text(
                            state.confirmed ?
                              'Escanear siguiente' :
                              'Confirmar Registro'
                            )
                        ]
                      )
                    )
                  ]
                );
              }
            )
          )
        )
      ),
    );
  }

  String _timeOfDayToString(TimeOfDay? time) =>
    time == null? '---' :
    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}