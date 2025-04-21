import 'package:flutter/material.dart';
import 'package:talent_showcase_app/core/core_exports.dart'
    show AppConfig, MyTheme, NavigationService, RouteNames, getIt;

import 'package:talent_showcase_app/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final MyTheme myTheme = getIt<MyTheme>();
    final AppRoutes appRouter = getIt<AppRoutes>();
    final NavigationService navigationService = getIt<NavigationService>();

    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: AppConfig.debugShowCheckedModeBanner,
      themeMode: AppConfig.themeMode,
      theme: myTheme.getTheme,
      initialRoute: RouteNames.initialPageRoute,
      onGenerateRoute: appRouter.onGenerateRoute,
      navigatorKey: navigationService.navigatorKey,
    );
  }
}
