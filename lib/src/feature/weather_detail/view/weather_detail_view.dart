import 'package:demo_weather_app/src/feature/weather_detail/logic/weather_detail_bloc.dart';
import 'package:demo_weather_app/src/network/model/city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetailView extends StatelessWidget {
  final NCity city;
  const WeatherDetailView({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => WeatherDetailBloc(city: city),
        child: BlocBuilder<WeatherDetailBloc, WeatherDetailState>(
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xFFEEF2DD),
                    title: const Text("Weather Detail",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                body: Container(
                    // color: Colors.lightBlue,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(
                        "https://cdn.theatlantic.com/thumbor/i9jH00gdQ3Lov_7DI2xDujaTwQQ=/845x470:2635x1477/1600x900/media/img/mt/2016/03/RTX283V4/original.jpg",
                      ),
                      fit: BoxFit.cover,
                    )),
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text("Current weather",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.purple.shade100,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.center,
                            child: Text("City: ${city.name}",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.lightBlue.shade100,
                                  fontWeight: FontWeight.bold,
                                ))),
                        Visibility(
                            visible: state.isLoading,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Colors.black,
                            ))),
                        _weatherItem(
                          visible: state.weather.temperature2m != null,
                          label: "Temperature 2m: ",
                          value: "${state.weather.temperature2m} °C",
                          iconData: Icons.thermostat,
                          iconColor: Colors.red,
                        ),
                        _weatherItem(
                          visible: state.weather.relativehumidity2m != null,
                          label: "Relativehumidity 2m: ",
                          value: "${state.weather.relativehumidity2m} %",
                          iconData: Icons.bubble_chart,
                          iconColor: Colors.blue,
                        ),
                        _weatherItem(
                          visible: state.weather.rain != null,
                          label: "Rain: ",
                          value: "${state.weather.rain} mm",
                          iconData: Icons.water_drop,
                          iconColor: Colors.blue,
                        ),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(20),
                            child: Text("Weather for the next 7 days",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.purple.shade100,
                                  fontWeight: FontWeight.bold,
                                ))),
                        state.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(
                                color: Colors.black,
                              ))
                            : SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: state.weather.listDay?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.blue.shade400,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Text(
                                                    state.weather
                                                            .listDay?[index]
                                                            .toString() ??
                                                        '',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          Colors.purple.shade50,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))),
                                            _weatherItem(
                                              label: "Temperature 2m Max: ",
                                              value:
                                                  "${state.weather.temperature2mMax?[index] ?? ''} °C",
                                              iconData: Icons.thermostat,
                                              iconColor: Colors.red,
                                              isExpand: false,
                                            ),
                                            _weatherItem(
                                              label: "Temperature 2m Min: ",
                                              value:
                                                  "${state.weather.temperature2mMin?[index] ?? ''} °C",
                                              iconData: Icons.thermostat,
                                              iconColor: Colors.red,
                                              isExpand: false,
                                            ),
                                            _weatherItem(
                                              label: "Rain sum: ",
                                              value:
                                                  "${state.weather.rainSum?[index] ?? ''} mm",
                                              iconData: Icons.water_drop,
                                              iconColor: Colors.blue,
                                              isExpand: false,
                                            ),
                                          ],
                                        ));
                                  },
                                )),
                      ],
                    )));
          },
        ));
  }

  Widget _weatherItem({
    required String label,
    required String value,
    bool visible = true,
    required IconData iconData,
    required Color? iconColor,
    bool isExpand = true,
  }) {
    return Visibility(
        visible: visible,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightBlue.shade100,
            ),
            child: Row(
              children: [
                Icon(
                  iconData,
                  color: iconColor,
                ),
                const SizedBox(width: 5),
                isExpand
                    ? Expanded(
                        child: Text(label,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            )))
                    : Text(label,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        )),
                Text(value,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            )));
  }
}
