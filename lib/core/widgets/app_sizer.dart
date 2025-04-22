import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/utils/app_size_utils.dart';

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  Orientation orientation,
  DeviceType deviceType,
);

/// A widget that provides responsive design utilities.
class AppSizer extends StatelessWidget {
  const AppSizer({super.key, required this.builder});

  final ResponsiveBuilder builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            AppSizeUtils.setScreenSize(constraints);
            return builder(context, orientation, AppSizeUtils.deviceType);
          },
        );
      },
    );
  }
}