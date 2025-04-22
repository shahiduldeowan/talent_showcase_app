import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/constants/app_sizes.dart';

enum DeviceType { mobile, tablet, desktop }

class AppSizeUtils {
  AppSizeUtils._();

  static double width = AppDesignDimension.width.value.toDouble();
  static double height = AppDesignDimension.height.value.toDouble();
  static bool initialized = false;
  static DeviceType deviceType = DeviceType.mobile;

  /// Sets the screen size and determines the device type.
  static void setScreenSize(BoxConstraints constraints) {
    if (!initialized) {
      width = constraints.maxWidth;
      height = constraints.maxHeight;
      initialized = true;
    }

    // Determine device type based on width
    if (width >= 1024) {
      deviceType = DeviceType.desktop;
    } else if (width >= 600) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.mobile;
    }
  }
}
