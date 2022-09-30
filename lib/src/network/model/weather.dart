class NWeather {
  final int? id;
  final double? temperature2m;
  final double? relativehumidity2m;
  final double? rain;
  final List<double>? temperature2mMax;
  final List<double>? temperature2mMin;
  final List<double>? rainSum;
  final List<String>? listDay;

  NWeather({
    this.id,
    this.temperature2m,
    this.relativehumidity2m,
    this.rain,
    this.temperature2mMax,
    this.temperature2mMin,
    this.rainSum,
    this.listDay,
  });

  NWeather copyWith({
    double? temperature2m,
    double? relativehumidity2m,
    double? rain,
    List<double>? temperature2mMax,
    List<double>? temperature2mMin,
    List<double>? rainSum,
    List<String>? listDay,
  }) {
    return NWeather(
      temperature2m: temperature2m ?? this.temperature2m,
      relativehumidity2m: relativehumidity2m ?? this.relativehumidity2m,
      rain: rain ?? this.rain,
      temperature2mMax: temperature2mMax ?? this.temperature2mMax,
      temperature2mMin: temperature2mMin ?? this.temperature2mMin,
      rainSum: rainSum ?? this.rainSum,
      listDay: listDay ?? this.listDay,
    );
  }

  // factory NWeather.fromMap(Map map, {String? id}) {
  //   return NWeather(
  //     id: id ?? map["id"],
  //     temperature2m: map["temperature2m"],
  //     relativehumidity2m: map["relativehumidity2m"],
  //     rain: map["rain"],
  //     temperature2mMax: map["temperature2mMax"],
  //     temperature2mMin: map["temperature2mMin"],
  //     rainSum: map["rainSum"],
  //     listDay: map["listDay"],
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     "id": id,
  //     "temperature2m": temperature2m,
  //     "relativehumidity2m": relativehumidity2m,
  //     "rain": rain,
  //     "temperature2mMax": temperature2mMax,
  //     "temperature2mMin": temperature2mMin,
  //     "rainSum": rainSum,
  //     "listDay": listDay,
  //   };
  // }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NWeather &&
        other.id == id &&
        other.temperature2m == temperature2m &&
        other.relativehumidity2m == relativehumidity2m &&
        other.rain == rain &&
        other.temperature2mMax == temperature2mMax &&
        other.temperature2mMin == temperature2mMin &&
        other.rainSum == rainSum &&
        other.listDay == listDay;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        temperature2m.hashCode ^
        relativehumidity2m.hashCode ^
        rain.hashCode ^
        temperature2mMax.hashCode ^
        temperature2mMin.hashCode ^
        rainSum.hashCode ^
        listDay.hashCode;
  }
}
