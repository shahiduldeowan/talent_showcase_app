import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFD05D15);
  static const Color primaryContainer = Color(0xFFEEE9FF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color error = Color(0xFFE57373);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFDCE1EF);
  static const Color fontDark = Color(0xFF1A1A1A);
  static const Color fontGray = Color(0xFF7A7A7A);
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFDEFFE8);
  static const Color complementaryOrange = Color(0xFFF4A261);
}

class AppColorSchemes {
  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryContainer,
    onPrimary: AppColors.onPrimary,
    onError: AppColors.onError,
    error: AppColors.error,
    surface: AppColors.surface,
  );
}
