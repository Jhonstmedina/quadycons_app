import 'package:flutter/material.dart';
import 'package:quadycons/data/entities/check.dart';
import 'package:quadycons/data/entities/project.dart';
import 'package:quadycons/data/entities/register_type.dart';
import 'package:quadycons/data/entities/registration_status.dart';

class PendingRegistrationTile extends StatelessWidget {
  final String name;
  final RegisterType registrationType;
  final Check check;
  final Project project;
  final RegistrationStatus status;

  const PendingRegistrationTile({
    super.key,
    required this.name,
    required this.registrationType,
    required this.check,
    required this.project,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final registrationTypeText = registrationType == RegisterType.input ? 'Entrada' : 'Salida';
    final checkTime = '${check.time.hour.toString().padLeft(2, '0')}:${check.time.minute.toString().padLeft(2, '0')}';
    final statusText = status == RegistrationStatus.completed ? 'Asegurado' : 'No';
    final badgeColor = status == RegistrationStatus.completed ? Colors.green : Colors.amber;
    final badgeText = status == RegistrationStatus.completed ? 'Ok' : 'Pend.';
    final badgeTextColor = status == RegistrationStatus.completed ? Colors.white : Colors.black;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ]
      ),
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          // 1. Circular avatar
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              color: Colors.grey[600],
              size: 28,
            ),
          ),
          // 2. Spacing
          SizedBox(width: 10),
          // 3. Column with info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 3.1. Title
                Text(
                  '$name - $registrationTypeText',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                // 3.2. Subtitle
                Text(
                  '$checkTime - ${project.name} - $statusText',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  )
                )
              ]
            )
          ),
          // 4. Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              badgeText,
              style: TextStyle(
                color: badgeTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
