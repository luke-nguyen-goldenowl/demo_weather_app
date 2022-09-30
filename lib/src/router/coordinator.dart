import 'package:demo_weather_app/src/network/model/city.dart';
import 'package:demo_weather_app/src/router/router.dart';
import 'package:flutter/material.dart';

class XCoordinator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentState!.context;
  static NavigatorState get navigator => navigatorKey.currentState!;
  static void pop<T extends Object?>([T? result]) async {
    return navigatorKey.currentState!.pop(result);
  }

  static Future<T?> pushNamed<T extends Object?>(String routeName,
      {Object? arguments}) {
    return navigator.pushNamed(routeName, arguments: arguments);
  }

  static Future showWeatherDetailView(NCity city) {
    return pushNamed(
      RouterName.weatherDetail,
      arguments: city,
    );
  }
}
