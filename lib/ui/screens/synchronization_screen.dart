import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quadycons/domain/blocs/synchronization/synchronization_bloc.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/registration_status.dart';
import 'package:quadycons/injection_container.dart';
import 'package:quadycons/ui/widgets/custom_app_bar.dart';
import 'package:quadycons/ui/widgets/pending_registration_tile.dart';

class SynchronizationScreen extends StatelessWidget {
  const SynchronizationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width * 0.05;

    return BlocProvider<SynchronizationBloc>(
      create: (_) => sl<SynchronizationBloc>()
        ..add(GetPendingRegistrations()),
      child: Scaffold(
        backgroundColor: Color(0xFFF5F3FF),
        appBar: CustomAppBar(title: 'Últimos registros (local)'),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: BlocBuilder<SynchronizationBloc, SynchronizationState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Se sincronizan cuando haya conexión',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 20),

                    if(state is PendingRegistrationsLoaded && state.pendingRegistrations.isEmpty)
                      Center(
                        child: Text(
                          'No hay registros pendientes de sincronización.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    if(state is PendingRegistrationsLoaded && state.pendingRegistrations.isNotEmpty)
                      Expanded(
                        child: ListView.separated(
                          itemCount: state.pendingRegistrations.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final registration = state.pendingRegistrations[index];
                            return PendingRegistrationTile(
                              name: registration.registration.idCodeInfo.worker!.name,
                              registrationType: registration.registration.type,
                              check: registration.registration.check,
                              //project: registration.registration.idCodeInfo.worker.projectId,
                              //TODO: Corregir
                              project: Project(
                                id: 1,
                                name: 'p',
                                geoLocation: LatLng(lat: 1, lon: 2),
                                geoFence: 3
                              ),
                              status: registration.status
                            );
                          },
                        ),
                      ),
                    
                    ...[
                      // First tile
                      PendingRegistrationTile(
                        name: 'Armando Mendoza',
                        registrationType: RegisterType.checkIn,
                        check: Check(
                          time: DateTime.now(),
                          location: LatLng(lat: 0, lon: 0),
                        ),
                        project: Project(
                          id: 1,
                          name: 'Torre Norte',
                          geoLocation: LatLng(lat: 0, lon: 0),
                          geoFence: 100,
                        ),
                        status: RegistrationStatus.completed,
                      ),
                      SizedBox(height: 12),
                      // Second tile
                      PendingRegistrationTile(
                        name: 'María González',
                        registrationType: RegisterType.checkOut,
                        check: Check(
                          time: DateTime.now().add(const Duration(hours: 3)),
                          location: LatLng(lat: 0, lon: 0),
                        ),
                        project: Project(
                          id: 2,
                          name: 'Edificio Central',
                          geoLocation: LatLng(lat: 0, lon: 0),
                          geoFence: 150,
                        ),
                        status: RegistrationStatus.pending,
                      ),
                      const SizedBox(height: 20),
                      // Buttons row
                      Row(
                        children: [
                          // Clear button
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implement clear functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF5F3FF),
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
                                Icon(Icons.delete_outline),
                                SizedBox(width: 8),
                                Text('Limpiar'),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),
                          // Synchronize button
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implement synchronize functionality
                            },
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
                                Icon(Icons.send),
                                SizedBox(width: 8),
                                Text('Sincronizar ahora'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
