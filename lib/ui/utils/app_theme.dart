import 'package:flutter/material.dart';

class AppTheme {
  // Color principal
  static const Color primaryColor = Color(0xFF3B82F6);
  
  // Colores de texto
  static const Color titleColor = Colors.black;
  static const Color buttonLabelColor = Colors.white;
  static const Color normalTextColor = Colors.grey;
  
  // Color de los botones
  static const Color elevatedButtonColor = Color(0xFFE5E7EB);
  
  // Color de fondo para TextFields
  static const Color textFieldBackground = Color(0xFFEFF6FF);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      
      // Color primario de la app
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
      ),
      
      // Tema de botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          textStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Tema de botones de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(
            color: buttonLabelColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Tema de botones con borde
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: const BorderSide(color: primaryColor),
          textStyle: const TextStyle(
            color: buttonLabelColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Tema de FloatingActionButton
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: buttonLabelColor,
      ),
      
      // Tema de íconos
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      
      // Tema de TextFields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: textFieldBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: primaryColor,
            width: 1,
          ),
        ),
        labelStyle: const TextStyle(
          color: normalTextColor,
        ),
        floatingLabelStyle: const TextStyle(
          color: primaryColor,
        ),
      ),
      
      // Color del texto en TextFields
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
      ),
      
      // Tema de RadioButtons
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.grey;
        }),
      ),
      
      // Tema de Checkboxes
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.grey;
        }),
      ),
      
      // Tema de ProgressIndicators
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        circularTrackColor: Colors.transparent,
        linearTrackColor: Colors.transparent,
      ),
      
      // Tema de texto
      textTheme: const TextTheme(
        // Títulos grandes
        displayLarge: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.bold,
        ),
        
        // Títulos de encabezado
        headlineLarge: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w600,
        ),
        
        // Títulos
        titleLarge: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
          color: titleColor,
          fontWeight: FontWeight.w600,
        ),
        
        // Textos del cuerpo (normales) - usado también en TextFields
        bodyLarge: TextStyle(
          color: Colors.black,
        ),
        bodyMedium: TextStyle(
          color: normalTextColor,
        ),
        bodySmall: TextStyle(
          color: normalTextColor,
        ),
        
        // Labels
        labelLarge: TextStyle(
          color: normalTextColor,
        ),
        labelMedium: TextStyle(
          color: normalTextColor,
        ),
        labelSmall: TextStyle(
          color: normalTextColor,
        ),
      ),
      
      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      
      // Tema de PopupMenuButton
      popupMenuTheme: const PopupMenuThemeData(
        iconColor: Colors.black,
      ),
      
      // Tema de switches
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.grey;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor.withOpacity(0.5);
          }
          return Colors.grey.withOpacity(0.3);
        }),
      ),
      
      // Tema de sliders
      sliderTheme: const SliderThemeData(
        activeTrackColor: primaryColor,
        thumbColor: primaryColor,
        inactiveTrackColor: Colors.grey,
      ),
    );
  }
}
