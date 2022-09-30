import 'package:demo_weather_app/src/feature/common/view/not_found_view.dart';
import 'package:demo_weather_app/src/feature/home/view/home_view.dart';
import 'package:flutter/material.dart';

class RouterName {
  static const String home = '/list-city';
  static const String weatherDetail = 'weather-detail';
}

class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // final arg = settings.arguments;
    switch (settings.name) {
      case RouterName.home:
        return MaterialPageRoute(builder: (_) => const HomeView());

      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundView(),
        );
    }
  }
}
