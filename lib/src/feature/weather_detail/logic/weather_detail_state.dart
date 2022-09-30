part of 'weather_detail_bloc.dart';

class WeatherDetailState {
  final NWeather weather;
  final bool isLoading;

  WeatherDetailState({
    required this.weather,
    this.isLoading = false,
  });

  WeatherDetailState copyWith({
    NWeather? weather,
    bool? isLoading,
  }) {
    return WeatherDetailState(
      weather: weather ?? this.weather,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
