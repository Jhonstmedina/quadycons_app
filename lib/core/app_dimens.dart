import 'package:flutter/material.dart';

class AppDimens {
  static TextStyle? titleLargeStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: (Theme.of(context).textTheme.titleLarge?.fontSize ?? 24) * 0.9
    );

  static TextStyle? titleMediumStyle(BuildContext context) =>
    Theme.of(context).textTheme.titleMedium?.copyWith(
      fontSize: (Theme.of(context).textTheme.titleMedium?.fontSize ?? 16) * 0.9
    );

  static TextStyle? bodyLargeStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: (Theme.of(context).textTheme.bodyLarge?.fontSize ?? 14) * 0.75
    );
  
  static TextStyle? bodyMediumStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: (Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14) * 0.75
    );
  
  static TextStyle? bodySmallStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodySmall?.copyWith(
      fontSize: (Theme.of(context).textTheme.bodySmall?.fontSize ?? 14) * 0.85
    );
  
  static TextStyle? styleByScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Pantalla pequeña (< 360)
    if (screenWidth < 360) {
      return bodySmallStyle(context);
    }
    
    // Pantalla promedio o más grande (>= 360)
    return bodyLargeStyle(context);
  }
  
  static double getWidthPercentage(BuildContext context, double percentage) =>
    MediaQuery.of(context).size.width * percentage;
  
  static double getHeightPercentage(BuildContext context, double percentage) =>
    MediaQuery.of(context).size.height * percentage;
}