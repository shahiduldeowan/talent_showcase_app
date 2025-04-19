import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/theme/app_bar_styles.dart';
import 'package:talent_showcase_app/core/theme/app_colors.dart';
import 'package:talent_showcase_app/core/theme/app_text_styles.dart';
import 'package:talent_showcase_app/core/theme/fab_styles.dart';

class MyTheme {
  static ThemeData get getTheme => ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: AppColorSchemes.lightColorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTextStyles.textTheme(),
    floatingActionButtonTheme: FABStyles.floatingActionButtonTheme(),
    appBarTheme: AppBarStyles.appBarTheme(),
  );
}
