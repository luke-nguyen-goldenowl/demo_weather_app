import 'dart:convert';

import 'package:demo_weather_app/src/network/model/city.dart';
import 'package:demo_weather_app/src/router/coordinator.dart';
import 'package:demo_weather_app/src/service/user_prefs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'cities_state.dart';

class CitiesBloc extends Cubit<CitiesState> {
  CitiesBloc() : super(CitiesState()) {
    init();
  }

  final String apiSearchCity =
      "https://geocoding-api.open-meteo.com/v1/search?name=";

  Future<void> init() async {
    var cities = UserPrefs().getCities();
    emit(state.copyWith(availableCities: cities));
  }

  void onChangedText(String value) {
    emit(state.copyWith(searchText: value));
    _searchCities();
  }

  void _searchCities() async {
    String _previousSearch = state.searchText.toString();
    await Future.delayed(const Duration(milliseconds: 300));
    if (_previousSearch != state.searchText) return;

    var response = await http.get(
      Uri.parse(apiSearchCity + state.searchText),
    );
    var data = json.decode(response.body);
    if ((data["error"] ?? false) == true) {
      // print(data["reason"]);
    } else {
      List<NCity> cities = List.from(
        (data["results"] ?? []).map((e) => NCity.fromMap(e)),
      );
      emit(state.copyWith(cities: [...cities]));
    }
  }

  void onAddCity(NCity city) {
    List<NCity> cities = List.from(state.availableCities);
    if (!cities.contains(city)) {
      cities.add(city);
      emit(state.copyWith(availableCities: cities));
      UserPrefs().saveCities(cities);
    }
  }

  void onRemoveCity(NCity city) {
    List<NCity> cities = List.from(state.availableCities);
    cities.remove(city);
    emit(state.copyWith(availableCities: cities));
    UserPrefs().saveCities(cities);
  }

  void onShowWeatherDetail(NCity city) {
    XCoordinator.showWeatherDetailView(city);
  }
}
