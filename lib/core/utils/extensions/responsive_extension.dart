import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/constants/app_sizes.dart'
    show AppDesignDimension;
import 'package:talent_showcase_app/core/utils/app_size_utils.dart';

/// Extension on [num] to provide responsive design utilities.
extension ResponsiveExtension on num {
  /// Returns the height of an element based on the Figma design width.
  double get h => (this * AppSizeUtils.width) / AppDesignDimension.width.value;

  /// Returns the width of an element based on the Figma design width.
  double get w => (this * AppSizeUtils.width) / AppDesignDimension.width.value;

  /// Returns the font size based on the Figma design width.
  double get fs => (this * AppSizeUtils.width) / AppDesignDimension.width.value;
}

/// Extension on [double] for additional utilities.
extension AppSizeFormatExtension on double {
  /// Returns a [SizedBox] with the given height.
  SizedBox toVerticalSpace() {
    return SizedBox(height: this);
  }

  /// Returns a [SizedBox] with the given width.
  SizedBox toHorizontalSpace() {
    return SizedBox(width: this);
  }

  /// Returns an [EdgeInsets] with uniform padding on all sides
  /// equal to the current [double] value.
  EdgeInsets toAllEdgeInsets() {
    return EdgeInsets.all(this);
  }

  /// Returns an [EdgeInsets] with uniform horizontal padding equal to the current
  /// [double] value. The vertical padding is set to 0.
  EdgeInsets toHorizontalEdgeInsets() {
    return EdgeInsets.symmetric(horizontal: this);
  }

  /// Returns an [EdgeInsets] with uniform left padding equal to the current
  /// [double] value. The other padding values are set to 0.
  EdgeInsets toLeftEdgeInsets() {
    return EdgeInsets.only(left: this);
  }

  /// Returns a [BorderRadius] where all corners have the same radius
  /// specified by the current [double] value.
  BorderRadius toAllBorderRadius() {
    return BorderRadius.all(Radius.circular(this));
  }
}
