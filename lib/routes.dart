import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/features/auth/presentation/pages/login_page.dart';
import 'package:talent_showcase_app/features/home/presentation/pages/home_page.dart';
import 'package:talent_showcase_app/features/splash/presentation/pages/splash_page.dart';

import 'core/core_exports.dart' show RouteNames;

@singleton
class AppRoutes {
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RouteNames.initialPageRoute: (_) => const SplashPage(),
    RouteNames.loginPageRoute: (_) => const LoginPage(),
    RouteNames.homePageRoute: (_) => const HomePage(),
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final WidgetBuilder? builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute<Widget>(builder: builder, settings: settings);
    }
    return null;
  }
}
