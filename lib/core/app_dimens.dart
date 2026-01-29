import 'package:flutter/material.dart';

class AppDimens {
  static TextStyle? titleLargeStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 24) * 0.9
    );
}