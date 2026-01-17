import 'package:flutter/material.dart';
import 'package:quadycons/domain/entities/check.dart';
import 'package:quadycons/domain/entities/lat_lng.dart';
import 'package:quadycons/domain/entities/project.dart';
import 'package:quadycons/domain/entities/register_type.dart';
import 'package:quadycons/domain/entities/registration_status.dart';
import 'package:quadycons/ui/widgets/custom_app_bar.dart';
import 'package:quadycons/ui/widgets/pending_registration_tile.dart';

class SynchronizeScreen extends StatelessWidget {
  const SynchronizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      appBar: CustomAppBar(title: 'Últimos registros (local)'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Se sincronizan cuando haya conexión',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                )
              ),
              SizedBox(height: 20),
              // First tile
              PendingRegistrationTile(
                name: 'Armando Mendoza',
                registrationType: RegisterType.input,
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
                registrationType: RegisterType.output,
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
              const SizedBox(
                height: 20
              ),
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
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
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
          ),
        ),
      ),
    );
  }
}
