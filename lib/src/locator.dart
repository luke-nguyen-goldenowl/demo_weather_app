import 'package:demo_weather_app/src/service/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // _locator();
  await Future.wait([
    //   Firebase.initializeApp(),
    //   // AnalyticsService.instance.init(),
    UserPrefs.instance.initialize(),
  ]);
}

// void _locator() {
//   GetIt.I
//     ..registerLazySingleton(() => DomainManager())
//     ..registerLazySingleton(() => AccountBloc())
//     ..registerLazySingleton(() => LocationBloc());
// }
