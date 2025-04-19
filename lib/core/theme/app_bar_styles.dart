import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/theme/app_colors.dart';
import 'package:talent_showcase_app/core/theme/app_text_styles.dart';

class AppBarStyles {
  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      color: AppColors.background,
      elevation: 0,
      titleTextStyle: AppTextStyles.appBarTitleStyle,
      toolbarHeight: 50,
    );
  }
}
