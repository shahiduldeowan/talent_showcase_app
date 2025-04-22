import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/constants/app_sizes.dart';
import 'package:talent_showcase_app/core/theme/app_colors.dart' show AppColors;
import 'package:talent_showcase_app/core/utils/extensions/responsive_extension.dart';

class InputTextFieldStyles {
  static OutlineInputBorder get outlineGray => OutlineInputBorder(
    borderRadius: AppSizes.borderRadiusM.toAllBorderRadius(),
    borderSide: BorderSide(
      color: AppColors.border.withValues(alpha: 0.49),
      width: 1,
    ),
  );

  static InputDecorationTheme inputDecorationTheme() {
    return InputDecorationTheme(
      fillColor: AppColors.primaryContainer,
      filled: true,
      border: outlineGray,
      enabledBorder: outlineGray,
      // focusedBorder: outlineGray,
    );
  }
}
