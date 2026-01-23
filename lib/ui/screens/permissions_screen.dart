import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quadycons/domain/blocs/permissions/permissions_bloc.dart';
import 'package:quadycons/injection_container.dart';
import 'package:quadycons/ui/widgets/permission_tile.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PermissionsBloc>.value(
      value: sl<PermissionsBloc>(),
      child: Scaffold(
        body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05
          ),
          child: BlocConsumer<PermissionsBloc, PermissionsState>(
            listener: (_, state) {
              if(state is PermissionsPending && state.cameraIsGranted && state.locationIsGranted) {
                context.go('/id-code-scan');
              }
            },
            builder: (context, state) {
              state = state as PermissionsPending;
              if(state.isLoading) {
                return Center(
                  child: CircularProgressIndicator()
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  // Título con badge "Necesarios"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Permisos Requeridos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24
                        )
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text(
                          'Necesarios',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                          )
                        )
                      )
                    ]
                  ),
                  SizedBox(height: 16),
                  // Permiso de cámara
                  PermissionTile(
                    icon: Icons.camera_alt_outlined,
                    text: 'Acceso a cámara',
                    isGranted: state.cameraIsGranted
                  ),
                  SizedBox(height: 8),
                  // Permiso de ubicación GPS
                  PermissionTile(
                    icon: Icons.location_on_outlined,
                    text: 'Acceso a ubicación GPS',
                    isGranted: state.locationIsGranted
                  ),
                  SizedBox(height: 24),
                  // Botón de otorgar permisos
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<PermissionsBloc>().add(RequestPermissions());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF5F3FF),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            color: Colors.black
                          ),
                          SizedBox(width: 8),
                          Text('Otorgar permisos')
                        ]
                      )
                    )
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
}
