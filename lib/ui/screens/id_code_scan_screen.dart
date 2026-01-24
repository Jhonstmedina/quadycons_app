import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/id_code_info.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/registration.dart';
import 'package:quadycons/domain/blocs/code_scan/code_scan_bloc.dart';
import 'package:quadycons/injection_container.dart';
import 'package:quadycons/ui/widgets/scan_button.dart';
import 'package:quadycons/ui/widgets/radio_scan_button.dart';
import 'package:quadycons/ui/widgets/projects_select.dart';
import 'package:quadycons/ui/widgets/custom_app_bar.dart';

class IdCodeScanScreen extends StatelessWidget {
  const IdCodeScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Escaneo de cédula / QR'),
      body: BlocProvider(
        create: (context) => sl<CodeScanBloc>(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: BlocConsumer<CodeScanBloc, CodeScanState>(
              listener: (context, state) {
                if ((state as Registrating).errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                      backgroundColor: Colors.red,
                    )
                  );
                }
                if(state.idDocInfo != null) {
                  final workerProject = state.idDocInfo!.worker?.project;
                  if( workerProject != null &&
                     workerProject.id != (context.read<ProjectsBloc>().state as ProjectsLoaded)
                      .chosenProject?.id
                  ) {
                    context.read<ProjectsBloc>().add(ChooseProject(
                      project: workerProject
                    ));
                  }
                  if (state.registerType != null &&
                    state.idDocInfo != null &&
                    (state.isInFence ?? false)
                  ) {
                    context.read<CodeScanBloc>().add(ResetBloc());
                    context.push(
                      '/register-confirmation',
                      extra: Registration(
                        check: Check(
                          time: DateTime.now(),
                          location: state.currentLocation!,
                        ),
                        idCodeInfo: state.idDocInfo!,
                        type: state.registerType!,
                      ),
                    );
                  }
                }
                
              },
              builder: (context, state) {
                state = state as Registrating;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<bool>(
                      stream: sl<ConnectivityService>().connectivityStream,
                      initialData: false,
                      builder: (context, snapshot) {
                        final isConnected = snapshot.data ?? false;
                        if (!isConnected) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Chip(
                              label: Text(
                                'offline solo',
                                style: TextStyle(fontSize: 12),
                              ),
                              backgroundColor: Colors.green,
                              labelStyle: TextStyle(color: Colors.white),
                              labelPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                              visualDensity: VisualDensity.compact,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          );
                        }
                        return Container();
                      }
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5F3FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_scanner, size: 80, weight: 700),
                          SizedBox(height: 16),
                          Text(
                            'apunta al código de barras de la cédula o al QR',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16),
                          if (state.idDocInfo != null)
                            Text(
                              state.idDocInfo!.docNumber,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          BlocBuilder<ProjectsBloc, ProjectsState>(
                            builder: (context, state) {
                              return TextButton(
                                onPressed: state is! ProjectsLoaded ?
                                  null :
                                  () async {
                                    _scan(context);
                                  },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: state is ProjectsLoaded ? 
                                        Colors.black : 
                                        Colors.grey,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Abrir cámara',
                                      style: TextStyle(
                                        color: state is ProjectsLoaded ? 
                                          Colors.black : 
                                          Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ScanRegistrationButton(
                          icon: Icons.login,
                          text: 'Entrada',
                          registerType: RegisterType.checkIn,
                        ),
                        ScanRegistrationButton(
                          icon: Icons.logout,
                          text: 'Salida',
                          registerType: RegisterType.checkOut,
                        ),
                        ScanButton(
                          icon: Icons.refresh,
                          text: 'Reintentar',
                          onPressed: () {
                            _scan(context);
                          },
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    ProjectsSelect(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _scan(BuildContext context) async {
    final projects = (context.read<ProjectsBloc>().state as ProjectsLoaded).projects;
    var chosenProject = (context.read<ProjectsBloc>().state as ProjectsLoaded).chosenProject;
    final codeScanBloc = context.read<CodeScanBloc>();
    final idCodeInfo = await context.push<IdCodeInfo?>('/scanner');
    if(idCodeInfo?.worker?.project != null) {
      chosenProject = projects.firstWhere(
        (project) => project.id == idCodeInfo!.worker!.project!.id
      );
    }
    codeScanBloc.add(InsertScanInfo(idCodeInfo, chosenProject!, projects));
  }
}
