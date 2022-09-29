import 'package:demo_weather_app/src/router/coordinator.dart';
import 'package:flutter/material.dart';

abstract class BaseCoordinator {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  String get initialRoute;

  Route<dynamic>? onGenerateRoute(RouteSettings settings);
  Future? pushNamed(String route) {
    return navigatorKey.currentState!.pushNamed(route);
  }

  void onExit() {
    XCoordinator.pop();
  }

  void pop([dynamic result]) {
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop(result);
    } else {
      onExit();
    }
  }

  void popOnly([dynamic result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState!.pop(result);
    }
  }

  Navigator getNavigator({String? customInitialRoute}) => Navigator(
        key: navigatorKey,
        initialRoute: customInitialRoute ?? initialRoute,
        onGenerateRoute: onGenerateRoute,
      );
}
