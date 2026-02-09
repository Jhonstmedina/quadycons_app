import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quadycons/core/app_dimens.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/domain/blocs/register_confirmation/register_confirmation_bloc.dart';
import 'package:quadycons/ui/utils/snack_manager.dart';
import 'package:quadycons/ui/widgets/box.dart';
import 'package:quadycons/ui/widgets/projects_select.dart';
import 'package:quadycons/ui/widgets/register_time.dart';
import 'package:quadycons/ui/widgets/custom_app_bar.dart';

class RegisterConfirmationScreen extends StatelessWidget {

  const RegisterConfirmationScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Confirmación'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
          child: BlocConsumer<RegisterConfirmationBloc, RegisterConfirmationState>(
            listener: (blocContext, state) {
              if (state is OnRegistration && state.error != null) {
                SnackManager.showSnackBar(
                  context,
                  state.error!.message,
                  backgroundColor: Colors.amber,
                  textColor: Colors.black,
                  icon: Icons.error_outline
                );
              }
            },
            builder: (context, state) {
              if(state is RegisterConfirmationInitial) {
                return Center(
                  child: CircularProgressIndicator()
                );
              }
              final registration = (state as OnRegistration).attendance;
              return Column(
                children: [
                  Center(
                    child: Box(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    'Proyecto: ${registration.idCodeInfo.worker?.project?.name ?? ''} ${_dateTimeToString(registration.checkin?.time)}${registration.checkout != null ? ' - ${_dateTimeToString(registration.checkout?.time)}' : ''}',
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
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.person,
                                      size: MediaQuery.of(context).size.width * 0.1,
                                      color: Colors.white
                                    );
                                  },
                                )
                              ): Icon(
                                Icons.person,
                                size: MediaQuery.of(context).size.width * 0.1,
                                color: Colors.white
                              )
                          ),
                          const SizedBox(width: 16),
                          // Columna con nombre y descripción
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  registration.idCodeInfo.worker?.name ?? 'Nombre no disponible',
                                  style: Theme.of(context).textTheme.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                                Text(
                                  '${registration.idCodeInfo.worker?.position ?? 'Posición no disponible'} - Cédula ${registration.idCodeInfo.docNumber}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14
                                  )
                                )
                              ]
                            ),
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
                                      registration.checkin != null ?
                                        Icons.login :
                                        Icons.logout,
                                      size: 18
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Registro: ${registration.checkin != null? "Entrada": "Salida"}',
                                      style: TextStyle(
                                        fontSize: AppDimens.bodyMediumStyle(context)?.fontSize,
                                        color: Theme.of(context).iconTheme.color
                                      )
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
                                    fontSize: AppDimens.bodyMediumStyle(context)?.fontSize
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
                              text: _dateTimeToString(registration.checkin?.time)
                            )
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: RegisterTime(
                              title: 'Hora de salida',
                              text: _dateTimeToString(registration.checkout?.time)
                            )
                          )
                        ]
                      ),
                      const SizedBox(height: 24),
                      
                      // Botón regresar
                      if(state.error?.type == RegisterConfirmErrorType.inconsistentAttendance)
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            context.go('/id-code-scan');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFF5F3FF),
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            minimumSize: Size(double.infinity, 0)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                size: 15,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Regresar'
                              )
                            ]
                          )
                        ),
                    
                      // Botón confirmar
                      if(state.error?.type != RegisterConfirmErrorType.inconsistentAttendance)
                        ElevatedButton(
                          onPressed: () {
                            if(state.confirmed) {
                              context.go('/id-code-scan');
                            } else {
                              context.read<RegisterConfirmationBloc>().add(ConfirmRegistration(
                                project: (context.read<ProjectsBloc>().state as ProjectsLoaded).chosenProject!
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.confirmed || state.isLoading?
                              Color(0xFFF5F3FF) :
                              Colors.blue[700],
                            foregroundColor: state.confirmed?
                              Colors.black :
                              state.isLoading?
                                Colors.grey:
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
                                state.confirmed?
                                  'Escanear siguiente' :
                                  'Confirmar Registro'
                                )
                            ]
                          )
                        )
                      ]
                    )
                  )
                ),
                Expanded(
                  child: Container()
                ),
                ProjectsSelect()
              ]
            );
          }
        )
      )
    )
  );
}

  String _dateTimeToString(DateTime? time) =>
    time == null? '---' :
    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}