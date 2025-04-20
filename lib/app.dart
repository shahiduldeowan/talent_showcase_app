import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show AppConfig, MyTheme, NavigationService, RouteNames;
import 'package:talent_showcase_app/core/di/di.dart' show getIt;
import 'package:talent_showcase_app/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: AppConfig.debugShowCheckedModeBanner,
      themeMode: AppConfig.themeMode,
      theme: getIt<MyTheme>().getTheme,
      initialRoute: RouteNames.initialPageRoute,
      onGenerateRoute: getIt<AppRoutes>().onGenerateRoute,
      navigatorKey: getIt<NavigationService>().navigatorKey,
    );
  }
}
