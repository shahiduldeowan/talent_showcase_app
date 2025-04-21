import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/theme/app_colors.dart';

class AppGradients {
  static LinearGradient get primary => const LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: <Color>[AppColors.primary, AppColors.complementaryOrange],
    stops: <double>[0.0, 1.0],
  );

  static LinearGradient get secondary => LinearGradient(
    colors: <Color>[
      AppColors.primary.withAlpha((0.8 * 255).toInt()),
      AppColors.complementaryOrange.withAlpha((0.9 * 255).toInt()),
    ],
  );
}
