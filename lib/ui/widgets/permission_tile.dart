import 'package:flutter/material.dart';
import 'package:quadycons/core/app_dimens.dart';

class PermissionTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isGranted;

  const PermissionTile({
    super.key,
    required this.icon,
    required this.text,
    required this.isGranted
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.black
            ),
            SizedBox(width: 12),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize
              )
            )
          ]
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isGranted ? Colors.green : Colors.yellow[700],
            borderRadius: BorderRadius.circular(30)
          ),
          child: Text(
            isGranted ? 'Otorgado' : 'Solicitar',
            style: TextStyle(
              color: isGranted ? Colors.white : Colors.black,
              fontSize: AppDimens.bodySmallStyle(context)?.fontSize
            )
          )
        )
      ]
    );
  }
}