import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/theme/app_colors.dart';

class FABStyles {
  static FloatingActionButtonThemeData floatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.background,
    );
  }
}
