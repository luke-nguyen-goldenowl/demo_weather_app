import 'package:demo_weather_app/src/feature/home/logic/cities_bloc.dart';
import 'package:demo_weather_app/src/widget/forms/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CitiesBloc(),
        child: BlocBuilder<CitiesBloc, CitiesState>(
          builder: (context, state) {
            var bloc = context.read<CitiesBloc>();
            return Scaffold(
                appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: const Color(0xFFEEF2DD),
                    title: const Text("Weather App",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))),
                body: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: XInput(
                          value: state.searchText,
                          onChanged: (value) => bloc.onChangedText(value),
                          textInputAction: TextInputAction.search,
                          cursorColor: const Color(0xFF686868),
                          maxLines: 1,
                          suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GestureDetector(
                                  onTap: () => bloc.onSearchCities(),
                                  child: const Icon(
                                    Icons.search,
                                    color: Color(0xFF41B245),
                                  ))),
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(20),
                              hintText:
                                  "search which city you want to know its weather",
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFFACCF28)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Color(0xFF41B245)),
                                borderRadius: BorderRadius.circular(50),
                              )),
                        )),
                    Expanded(
                        child: state.cities.isEmpty
                            ? Center(
                                child: Text("There are no cities",
                                    style: TextStyle(
                                      color: Colors.grey.withOpacity(0.6),
                                      fontSize: 20,
                                    )))
                            : ListView.builder(
                                padding: const EdgeInsets.all(20),
                                shrinkWrap: true,
                                itemCount: state.cities.length,
                                itemBuilder: (context, index) {
                                  var item = state.cities[index];
                                  return Row(
                                    children: [
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () =>
                                            bloc.onShowWeatherDetail(item),
                                        child: Text(
                                            "${item.name}, ${item.timezone}, ${item.country}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                            )),
                                      )),
                                      IconButton(
                                          onPressed: () => bloc.onAddCity(item),
                                          icon: const Icon(
                                            Icons.add,
                                          )),
                                    ],
                                  );
                                },
                              )),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.pink,
                        ),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        child: const Text("Tracking Cities",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ))),
                    Expanded(
                        child: ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: state.availableCities.length,
                      itemBuilder: (context, index) {
                        var item = state.availableCities[index];
                        return Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: () => bloc.onShowWeatherDetail(item),
                              child: Text(
                                  "${item.name}, ${item.timezone}, ${item.country}",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  )),
                            )),
                            IconButton(
                                onPressed: () => bloc.onRemoveCity(item),
                                icon: const Icon(
                                  Icons.remove,
                                )),
                          ],
                        );
                      },
                    )),
                  ],
                ));
          },
        ));
  }
}
