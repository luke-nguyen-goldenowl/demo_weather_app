class NCity {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String timezone;
  final String country;

  NCity({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.country,
  });

  NCity copyWith({
    String? name,
    double? latitude,
    double? longitude,
    String? timezone,
    String? country,
  }) {
    return NCity(
      id: id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timezone: timezone ?? this.timezone,
      country: country ?? this.country,
    );
  }

  factory NCity.fromMap(Map map, {String? id}) {
    return NCity(
      id: id ?? map["id"],
      name: map["name"],
      latitude: map["latitude"],
      longitude: map["longitude"],
      timezone: map["timezone"],
      country: map["country"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "latitude": latitude,
      "longitude": longitude,
      "timezone": timezone,
      "country": country,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NCity &&
        other.id == id &&
        other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.timezone == timezone &&
        other.country == country;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        timezone.hashCode ^
        country.hashCode;
  }
}
