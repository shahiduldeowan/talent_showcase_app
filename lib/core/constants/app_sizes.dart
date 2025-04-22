enum AppDesignDimension {
  width(375),
  height(812),
  statusBarHeight(0);

  const AppDesignDimension(this._value);

  final num _value;

  /// Returns the value of the enum.
  num get value => _value;
}

class AppSizes {
  // 🔹 Padding & Margin
  static const double paddingXS = 6.0;
  static const double paddingMM = 14.0;
  static const double paddingL = 16.0;
  static const double paddingXL = 20.0;
  static const double paddingXXL = 24.0;

  // 🔹 Font Sizes
  static const double fontXS = 12.0;
  static const double fontXL = 24.0;

  // 🔹 Spacing (Gap between elements)
  static const double spaceS = 8.0;
  static const double spaceM = 12.0;
  static const double spaceL = 16.0;
  static const double spaceXL = 20.0;

  // 🔹 Border Radius
  static const double borderRadiusM = 12.0;
  static const double borderRadiusMM = 14.0;
  static const double borderRadiusL = 16.0;
  static const double borderRadiusXL = 20.0;
  static const double borderRadiusXXXL = 34.0;
}
