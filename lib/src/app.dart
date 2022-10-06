import 'package:demo_weather_app/src/router/coordinator.dart';
import 'package:demo_weather_app/src/router/router.dart';
import 'package:demo_weather_app/src/theme/themes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: XCoordinator.navigatorKey,
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', ''),
      ],
      theme: XTheme.light(),
      initialRoute: RouterName.home,
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
