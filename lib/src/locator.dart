import 'package:demo_weather_app/src/service/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Future.wait([
    UserPrefs.instance.initialize(),
  ]);
}
