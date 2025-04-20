import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Helper to get the current navigator state or throw an exception if uninitialized.
  NavigatorState get _navigator {
    final NavigatorState? navigator = navigatorKey.currentState;
    if (navigator == null) {
      throw Exception('Navigator is not initialized.');
    }
    return navigator;
  }

  /// Navigate to a new route by its name.
  Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    return _navigator.pushNamed(routeName, arguments: arguments);
  }

  /// Navigate to a new route and remove all previous routes from the stack.
  Future<dynamic> navigateAndRemoveUntil(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return _navigator.pushNamedAndRemoveUntil(
      routeName,
      predicate ?? (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  /// Navigate back to the previous route.
  void goBack() {
    if (_navigator.canPop()) {
      _navigator.pop();
    } else {
      debugPrint('No routes to pop.');
    }
  }
}
