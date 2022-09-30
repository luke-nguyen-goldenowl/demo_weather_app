import 'dart:convert';

import 'package:demo_weather_app/src/network/model/city.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XKeys {
  static const String cities = 'cities';
}

class UserPrefs {
  factory UserPrefs() => instance;
  UserPrefs._internal();

  static final UserPrefs instance = UserPrefs._internal();
  late SharedPreferences _prefs;
  Future initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // cities
  List<NCity> getCities() {
    String? value = _prefs.getString(XKeys.cities);
    if (value?.isNotEmpty == true) {
      List<dynamic> map = json.decode(value!);
      return List.from(map.map((e) => NCity.fromMap(e)));
    }
    return [];
  }

  void saveCities(List<NCity> cities) {
    String? value = json.encode(List.from(cities.map((e) => e.toMap())));
    _prefs.setString(XKeys.cities, value);
  }
}
