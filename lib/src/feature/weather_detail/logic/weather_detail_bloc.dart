import 'dart:convert';

import 'package:demo_weather_app/src/network/model/city.dart';
import 'package:demo_weather_app/src/network/model/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'weather_detail_state.dart';

class WeatherDetailBloc extends Cubit<WeatherDetailState> {
  final NCity city;
  WeatherDetailBloc({
    required this.city,
  }) : super(WeatherDetailState(weather: NWeather())) {
    init();
  }

  String weatherHourlyApiUrl(String lat, String long, String dataType) =>
      "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&hourly=$dataType";
  String weatherDailyApiUrl(
          String lat, String long, String timezone, String dataType) =>
      "https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$long&timezone=$timezone&daily=$dataType";

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
    var hour = DateTime.now().hour;
    var temperature2mRes = await http.get(Uri.parse(weatherHourlyApiUrl(
      city.latitude.toString(),
      city.longitude.toString(),
      "temperature_2m",
    )));
    var relativehumidity2mRes = await http.get(Uri.parse(weatherHourlyApiUrl(
      city.latitude.toString(),
      city.longitude.toString(),
      "relativehumidity_2m",
    )));
    var rainRes = await http.get(Uri.parse(weatherHourlyApiUrl(
      city.latitude.toString(),
      city.longitude.toString(),
      "rain",
    )));
    var temperature2mMaxRes = await http.get(Uri.parse(weatherDailyApiUrl(
      city.latitude.toString(),
      city.longitude.toString(),
      city.timezone,
      "temperature_2m_max",
    )));
    var temperature2mMinRes = await http.get(Uri.parse(weatherDailyApiUrl(
      city.latitude.toString(),
      city.longitude.toString(),
      city.timezone,
      "temperature_2m_min",
    )));
    var rainSumRes = await http.get(Uri.parse(weatherDailyApiUrl(
      city.latitude.toString(),
      city.longitude.toString(),
      city.timezone,
      "rain_sum",
    )));
    double? temperature2m =
        jsonDecode(temperature2mRes.body)["hourly"]["temperature_2m"][hour];
    double? relativehumidity2m =
        jsonDecode(relativehumidity2mRes.body)["hourly"]["relativehumidity_2m"]
            [hour];
    double? rain = jsonDecode(rainRes.body)["hourly"]["rain"][hour];
    List<double>? temperature2mMax = List.from(
        jsonDecode(temperature2mMaxRes.body)["daily"]["temperature_2m_max"]
            .map((e) => double.parse(e.toString())));
    List<double>? temperature2mMin = List.from(
        jsonDecode(temperature2mMinRes.body)["daily"]["temperature_2m_min"]
            .map((e) => double.parse(e.toString())));
    List<double>? rainSum = List.from(jsonDecode(rainSumRes.body)["daily"]
            ["rain_sum"]
        .map((e) => double.parse(e.toString())));
    List<String> listDay =
        List.from(jsonDecode(rainSumRes.body)["daily"]["time"]);

    var weather = NWeather(
      temperature2m: temperature2m,
      relativehumidity2m: relativehumidity2m,
      rain: rain,
      temperature2mMax: temperature2mMax,
      temperature2mMin: temperature2mMin,
      rainSum: rainSum,
      listDay: listDay,
    );
    emit(state.copyWith(
      weather: weather,
      isLoading: false,
    ));
  }
}
