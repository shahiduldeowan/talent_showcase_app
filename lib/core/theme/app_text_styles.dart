import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const String _fontFamily = 'Poppins';

  static TextTheme textTheme() => TextTheme(
    bodyLarge: _textStyle(16, FontWeight.w400),
    bodyMedium: _textStyle(14, FontWeight.w500),
    bodySmall: _textStyle(12, FontWeight.w400, color: AppColors.fontGray),
    headlineLarge: _textStyle(32, FontWeight.w800),
    headlineMedium: _textStyle(28, FontWeight.w700),
    headlineSmall: _textStyle(24, FontWeight.w700),
    labelLarge: _textStyle(14, FontWeight.w600),
    labelMedium: _textStyle(12, FontWeight.w500),
    labelSmall: _textStyle(10, FontWeight.w500),
    titleLarge: _textStyle(20, FontWeight.w600),
    titleMedium: _textStyle(16, FontWeight.w600),
    titleSmall: _textStyle(14, FontWeight.w600),
  );

  static TextStyle get appBarTitleStyle => _textStyle(18, FontWeight.w600);

  static TextStyle _textStyle(double size, FontWeight weight, {Color? color}) {
    return TextStyle(
      color: color ?? AppColors.fontDark,
      fontSize: size,
      fontWeight: weight,
      fontFamily: _fontFamily,
    );
  }
}
