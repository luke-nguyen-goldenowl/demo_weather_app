import 'package:demo_weather_app/src/feature/home/view/home_view.dart';
import 'package:demo_weather_app/src/feature/weather_detail/view/weather_detail_view.dart';
import 'package:demo_weather_app/src/network/model/city.dart';
import 'package:flutter/material.dart';

class RouterName {
  static const String home = '/list-city';
  static const String weatherDetail = 'weather-detail';
}

class AppRoute {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final arg = settings.arguments;
    switch (settings.name) {
      case RouterName.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case RouterName.weatherDetail:
        return MaterialPageRoute(
            builder: (_) => WeatherDetailView(city: arg as NCity));

      default:
        return MaterialPageRoute(
          builder: (_) => const Text("Not Found"),
        );
    }
  }
}
