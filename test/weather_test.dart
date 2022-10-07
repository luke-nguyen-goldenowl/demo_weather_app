import 'dart:convert';

import 'package:demo_weather_app/src/network/model/city.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('Fetch data', () {
    test('Fetch cities', () {
      const jsonObject = '''{
          "results": [
            {
              "id": 2950159,
              "name": "Berlin",
              "latitude": 52.52437,
              "longitude": 13.41053,
              "elevation": 74.0,
              "feature_code": "PPLC",
              "country_code": "DE",
              "admin1_id": 2950157,
              "admin2_id": 0,
              "admin3_id": 6547383,
              "admin4_id": 6547539,
              "timezone": "Europe/Berlin",
              "population": 3426354,
              "postcodes": ["10967", "13347"],
              "country_id": 2921044,
              "country": "Deutschland",
              "admin1": "Berlin",
              "admin2": "",
              "admin3": "Berlin, Stadt",
              "admin4": "Berlin"
            }
          ]
        }''';
      var data = json.decode(jsonObject);
      List<NCity> cities = List.from(
        (data["results"] ?? []).map((e) => NCity.fromMap(e)),
      );
      expect(cities[0].id, 2950159);
      expect(cities[0].name, "Berlin");
      expect(cities[0].latitude, 52.52437);
      expect(cities[0].longitude, 13.41053);
      expect(cities[0].timezone, "Europe/Berlin");
      expect(cities[0].country, "Deutschland");
    });
  });
}
