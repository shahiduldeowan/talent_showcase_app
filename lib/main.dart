import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' show dotenv;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:talent_showcase_app/app.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show AppLogger, configureDependencies;

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await configureDependencies();
  AppLogger.debugEnabled = true;
  runApp(const App());
  FlutterNativeSplash.remove();
}

//flutter pub run build_runner clean
//flutter pub run build_runner build --delete-conflicting-outputs
