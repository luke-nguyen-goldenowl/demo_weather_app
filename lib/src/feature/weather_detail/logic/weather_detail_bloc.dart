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
    var temperature2mRes = await getHourlyResponse("temperature_2m");
    var relativehumidity2mRes = await getHourlyResponse("relativehumidity_2m");
    var rainRes = await getHourlyResponse("rain");
    var temperature2mMaxRes = await getDailyResponse("temperature_2m_max");
    var temperature2mMinRes = await getDailyResponse("temperature_2m_min");
    var rainSumRes = await getDailyResponse("rain_sum");

    double? temperature2m =
        getHourlyData(temperature2mRes.body, "temperature_2m");
    double? relativehumidity2m =
        getHourlyData(relativehumidity2mRes.body, "relativehumidity_2m");
    double? rain = getHourlyData(rainRes.body, "rain");
    List<double>? temperature2mMax =
        getDailyData(temperature2mMaxRes.body, "temperature_2m_max");
    List<double>? temperature2mMin =
        getDailyData(temperature2mMinRes.body, "temperature_2m_min");
    List<double>? rainSum = getDailyData(rainSumRes.body, "rain_sum");
    List<String>? listDay = getTimeData(rainSumRes.body);

    var weather = NWeather(
      temperature2m: temperature2m,
      relativehumidity2m: relativehumidity2m,
      rain: rain,
      temperature2mMax: temperature2mMax,
      temperature2mMin: temperature2mMin,
      rainSum: rainSum,
      listDay: listDay,
    );
    if (!isClosed) {
      emit(state.copyWith(
        weather: weather,
        isLoading: false,
      ));
    }
  }

  double? getHourlyData(String body, String param) {
    var hour = DateTime.now().hour;
    return (jsonDecode(body)["hourly"][param][hour] as num?)?.toDouble();
  }

  List<String>? getTimeData(String body) {
    return List.from(jsonDecode(body)["daily"]["time"]);
  }

  List<double>? getDailyData(String body, String param) {
    return List.from(jsonDecode(body)["daily"][param]
        .map((e) => double.parse(e.toString())));
  }

  Future<http.Response> getHourlyResponse(String param) {
    return http.get(Uri.parse(weatherHourlyApiUrl(
      city.latitude.toString(),
      city.longitude.toString(),
      param,
    )));
  }

  Future<http.Response> getDailyResponse(String param) {
    return http.get(Uri.parse(weatherDailyApiUrl(
      city.latitude.toString(),
      city.longitude.toString(),
      city.timezone,
      param,
    )));
  }

  void onPageChanged(int value) {
    emit(state.copyWith(currentPage: value));
  }
}
