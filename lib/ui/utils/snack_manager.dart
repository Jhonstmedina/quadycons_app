import 'package:flutter/material.dart';

class SnackManager {
  static void showSnackBar(
    BuildContext context,
    String message,
    {
      required IconData icon,
      required Color textColor,
      required Color backgroundColor
    }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon,
              color: textColor,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(color: textColor)
              )
            )
          ]
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        )
      )
    );
  }
}