import 'package:demo_weather_app/src/feature/weather_detail/logic/weather_detail_bloc.dart';
import 'package:demo_weather_app/src/network/model/city.dart';
import 'package:demo_weather_app/src/network/model/weather.dart';
import 'package:demo_weather_app/src/widget/common/custom_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetailView extends StatelessWidget {
  final NCity city;

  const WeatherDetailView({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => WeatherDetailBloc(city: city),
        child: BlocBuilder<WeatherDetailBloc, WeatherDetailState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(title: const Text("Weather Detail")),
                body: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.2, 0.8],
                      colors: [
                        Colors.black87,
                        Colors.grey,
                      ],
                    )),
                    child: state.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Colors.black,
                          ))
                        : ListView(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            children: [
                              XCustomTitle(
                                padding: const EdgeInsets.all(20),
                                title: "City: ${city.name}",
                                color: Colors.lightBlue.shade100,
                              ),
                              const XCustomTitle(
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                title: "Current weather",
                              ),
                              _temperature2m(state.weather.temperature2m),
                              _relativehumidity2m(
                                  state.weather.relativehumidity2m),
                              _rain(state.weather.rain),
                              const XCustomTitle(
                                padding: EdgeInsets.only(
                                  top: 30,
                                  bottom: 10,
                                  left: 20,
                                  right: 20,
                                ),
                                title: "Weather for the next 7 days",
                              ),
                              SizedBox(
                                  height: 250,
                                  child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        state.weather.listDay?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return _dailyItem(state.weather, index);
                                    },
                                  )),
                            ],
                          )));
          },
        ));
  }

  Widget _dailyItem(NWeather weather, int index) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.2, 0.8],
              colors: [
                Colors.blue.shade700.withAlpha(100),
                Colors.blue.shade200.withAlpha(100),
              ],
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(weather.listDay?[index].toString() ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple.shade50,
                      fontWeight: FontWeight.bold,
                    ))),
            _temperature2mMax(weather.temperature2mMax?[index]),
            _temperature2mMin(weather.temperature2mMin?[index]),
            _rainSum(weather.rainSum?[index]),
          ],
        ));
  }

  Widget _weatherItem({
    required String label,
    required String value,
    required IconData iconData,
    required Color? iconColor,
  }) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.pink.shade50,
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
            ),
            const SizedBox(width: 5),
            Expanded(
                child: Text(label,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ))),
            Text(value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ));
  }

  Widget _temperature2m(double? value) {
    return _weatherItem(
      label: "Temperature 2m: ",
      value: "$value °C",
      iconData: Icons.thermostat,
      iconColor: Colors.red,
    );
  }

  Widget _relativehumidity2m(double? value) {
    return _weatherItem(
      label: "Relativehumidity 2m: ",
      value: "$value %",
      iconData: Icons.bubble_chart,
      iconColor: Colors.blue,
    );
  }

  Widget _rain(double? value) {
    return _weatherItem(
      label: "Rain: ",
      value: "$value} mm",
      iconData: Icons.water_drop,
      iconColor: Colors.blue,
    );
  }

  Widget _temperature2mMax(double? value) {
    return _weatherItem(
      label: "Temperature 2m Max: ",
      value: "$value °C",
      iconData: Icons.thermostat,
      iconColor: Colors.red,
    );
  }

  Widget _temperature2mMin(double? value) {
    return _weatherItem(
      label: "Temperature 2m Min: ",
      value: "$value °C",
      iconData: Icons.thermostat,
      iconColor: Colors.red,
    );
  }

  Widget _rainSum(double? value) {
    return _weatherItem(
      label: "Rain sum: ",
      value: "$value mm",
      iconData: Icons.water_drop,
      iconColor: Colors.blue,
    );
  }
}
