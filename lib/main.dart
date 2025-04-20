import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:talent_showcase_app/app.dart';
import 'package:talent_showcase_app/core/di/di.dart' show configureDependencies;

void main() {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  configureDependencies();
  runApp(const App());
}

//flutter pub run build_runner build --delete-conflicting-outputs --build-filter="lib/core/di/*"
//flutter pub run build_runner build --delete-conflicting-outputs --verbose
//flutter pub run build_runner clean
//flutter pub run build_runner build --delete-conflicting-outputs

// whenever your initialization is completed, remove the splash screen:
    // FlutterNativeSplash.remove();

