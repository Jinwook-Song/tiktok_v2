import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFFE9435A);

  static ColorScheme fromBrightness({required Brightness brightness}) {
    return ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: primaryColor,
      // Customisation goes here
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppTheme.fromBrightness(
        brightness: Brightness.light,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppTheme.fromBrightness(
        brightness: Brightness.dark,
      ),
    );
  }
}
