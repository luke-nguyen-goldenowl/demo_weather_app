part of 'cities_bloc.dart';

class CitiesState {
  final List<NCity> cities;
  final List<NCity> availableCities;
  final String searchText;

  CitiesState({
    this.cities = const [],
    this.availableCities = const [],
    this.searchText = '',
  });

  CitiesState copyWith({
    List<NCity>? cities,
    List<NCity>? availableCities,
    String? searchText,
  }) {
    return CitiesState(
      cities: cities ?? this.cities,
      availableCities: availableCities ?? this.availableCities,
      searchText: searchText ?? this.searchText,
    );
  }
}
