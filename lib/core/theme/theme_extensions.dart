import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  // Quick access to colors
  Color get primaryColor => Theme.of(this).colorScheme.primary;

  // Quick access to text styles
  TextStyle get heading1 => Theme.of(this).textTheme.displayLarge!;
}
