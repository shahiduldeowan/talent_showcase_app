import 'dart:io' show Platform, exit;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemNavigator;
import 'package:talent_showcase_app/core/core_exports.dart' show AppConstants;

Future<void> appExitDialog(BuildContext context) async {
  bool shouldExit = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(AppConstants.areYourSure),
        content: const Text(AppConstants.areYouSureYouWantToExit),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(AppConstants.no),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(AppConstants.yes),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      );
    },
  );

  if (shouldExit == true) {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
