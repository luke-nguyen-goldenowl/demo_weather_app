part of 'weather_detail_bloc.dart';

class WeatherDetailState {
  final NWeather weather;
  final bool isLoading;
  final int currentPage;

  WeatherDetailState({
    required this.weather,
    this.isLoading = false,
    this.currentPage = 0,
  });

  WeatherDetailState copyWith({
    NWeather? weather,
    bool? isLoading,
    int? currentPage,
  }) {
    return WeatherDetailState(
      weather: weather ?? this.weather,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
