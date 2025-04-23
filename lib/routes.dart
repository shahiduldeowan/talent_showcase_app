import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:talent_showcase_app/features/auth/presentation/pages/login_page.dart';
import 'package:talent_showcase_app/features/feed/presentation/pages/create_post_page.dart';
import 'package:talent_showcase_app/features/main/presentation/pages/main_shell_page.dart';
import 'package:talent_showcase_app/features/splash/presentation/pages/splash_page.dart';

import 'core/core_exports.dart' show RouteNames;

@singleton
class AppRoutes {
  final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    RouteNames.initialPageRoute: (_) => const SplashPage(),
    RouteNames.loginPageRoute: (_) => const LoginPage(),
    RouteNames.mainShellPageRoute: (_) => const MainShellPage(),
    RouteNames.createPostPageRoute: (_) => const CreatePostPage(),
  };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final WidgetBuilder? builder = routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute<Widget>(builder: builder, settings: settings);
    }
    return null;
  }
}
