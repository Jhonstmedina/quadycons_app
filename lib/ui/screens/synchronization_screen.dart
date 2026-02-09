import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/core/app_dimens.dart';
import 'package:quadycons/domain/blocs/projects/projects_bloc.dart';
import 'package:quadycons/domain/blocs/synchronization/synchronization_bloc.dart';
import 'package:quadycons/domain/connectivity/connectivity_service.dart';
import 'package:quadycons/injection_container.dart';
import 'package:quadycons/ui/widgets/box.dart';
import 'package:quadycons/ui/widgets/custom_app_bar.dart';
import 'package:quadycons/ui/widgets/pending_registration_tile.dart';

class SynchronizationScreen extends StatelessWidget {
  const SynchronizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width * 0.05;

    return BlocProvider<SynchronizationBloc>(
      create: (_) => sl<SynchronizationBloc>()
        ..add(GetLastRegistrationsEvent(
          (context.read<ProjectsBloc>().state as ProjectsLoaded).projects
        )),
      child: Scaffold(
        appBar: CustomAppBar(title: ''),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: BlocBuilder<SynchronizationBloc, SynchronizationState>(
              builder: (context, state) {

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(state is LastRegistrationsLoaded && state.lastRegistrations.isEmpty)
                      Center(
                        child: Text(
                          'No hay registros pendientes de sincronización.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    if(state is LastRegistrationsLoaded && state.lastRegistrations.isNotEmpty)
                      Flexible(
                        child: Box(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Últimos registros (local)',
                                style: AppDimens.titleLargeStyle(context)
                              )
                            ),
                            SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Se sincronizan cuando haya conexión',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ),
                            SizedBox(height: 15),
                            Flexible(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.lastRegistrations.length,
                                separatorBuilder: (_, _) => SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final registration = state.lastRegistrations[index];
                                  return PendingRegistrationTile(
                                    name: registration.registration.idCodeInfo.worker!.name,
                                    registrationType: registration.registration.type,
                                    check: registration.registration.check,
                                    project: registration.registration.idCodeInfo.worker!.project!,
                                    status: registration.status
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Buttons row
                            Row(
                              children: [
                                // Clear button
                                ElevatedButton(
                                  onPressed: () {
                                    context.read<SynchronizationBloc>().add(CleanLastRegistrationsEvent(
                                      (context.read<ProjectsBloc>().state as ProjectsLoaded).projects
                                    ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    side: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.delete_outline,
                                        size: AppDimens.titleMediumStyle( context)?.fontSize,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Limpiar',
                                        style: AppDimens.bodyLargeStyle(context)
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12),
                                // Synchronize button
                                StreamBuilder<bool>(
                                  stream: sl<ConnectivityService>().connectivityStream,
                                  initialData: false,
                                  builder: (context, snapshot) {
                                    final isConnected = snapshot.data ?? false;
                                    return ElevatedButton(
                                      onPressed: state.canSynchronize && 
                                                isConnected ? () {
                                        context.read<SynchronizationBloc>().add(
                                          SynchronizeRegistrationsEvent(
                                            projects: (context.read<ProjectsBloc>().state as ProjectsLoaded).projects
                                          )
                                        );
                                      } : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[700],
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 20,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.send,
                                            size: AppDimens.titleMediumStyle( context)?.fontSize
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Sincronizar ahora',
                                            style: AppDimens.bodyLargeStyle(context),
                                          ),
                                        ]
                                      )
                                    );
                                  }
                                )
                              ]
                            ),
                          ],
                        ),
                        ),
                      ),
                    SizedBox(height: 16),
                  ]
                );
              }
            )
          )
        )
      )
    );
  }
}
