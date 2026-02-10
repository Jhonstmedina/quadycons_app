import 'package:flutter/material.dart';
import 'package:quadycons/core/app_dimens.dart';

class ScanButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const ScanButton({
    super.key, 
    required this.icon,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        foregroundColor: Colors.black,
        minimumSize: Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppDimens.bodySmallStyle(context)?.fontSize),
          SizedBox(width: 4),
          Text(
            text,
            style: AppDimens.styleByScreen(context)?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black
            )
          )
        ]
      )
    );
  }
}
