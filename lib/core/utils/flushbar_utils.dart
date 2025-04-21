import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:vibration/vibration.dart';

/// Enum to define the type of Flushbar.
enum FlushbarType { success, info, error }

/// Displays a Flushbar alert with the specified type.
void showAppAlert(
  BuildContext context, {
  required String message,
  String? title,
  FlushbarType type = FlushbarType.success,
  Duration duration = const Duration(seconds: 2),
}) {
  _vibrate();
  _createFlushbar(
    context,
    message: message,
    title: title,
    type: type,
    duration: duration,
  );
}

/// Creates and shows a Flushbar based on the type.
void _createFlushbar(
  BuildContext context, {
  required String message,
  String? title,
  required FlushbarType type,
  required Duration duration,
}) {
  final Flushbar<dynamic> flushbar = switch (type) {
    FlushbarType.success => FlushbarHelper.createSuccess(
      message: message,
      title: title,
      duration: duration,
    ),
    FlushbarType.info => FlushbarHelper.createInformation(
      message: message,
      title: title,
      duration: duration,
    ),
    FlushbarType.error => FlushbarHelper.createError(
      message: message,
      title: title,
      duration: duration,
    ),
  };

  flushbar.show(context);
}

/// Provides vibration feedback.
Future<void> _vibrate() async {
  try {
    if (await Vibration.hasCustomVibrationsSupport()) {
      await Vibration.vibrate(duration: 1000);
    } else {
      await Vibration.vibrate();
      await Future<dynamic>.delayed(const Duration(milliseconds: 500));
      await Vibration.vibrate();
    }
  } catch (e) {
    debugPrint('Vibration error: $e');
  }
}
