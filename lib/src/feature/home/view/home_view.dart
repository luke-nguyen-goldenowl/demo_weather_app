import 'package:demo_weather_app/src/feature/home/logic/cities_bloc.dart';
import 'package:demo_weather_app/src/widget/common/custom_title.dart';
import 'package:demo_weather_app/src/widget/forms/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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
                    title: const Text(
                      "Weather App",
                    )),
                body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const XCustomTitle(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          title: "Tracking Cities",
                        ),
                        Expanded(
                            flex: 2,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.availableCities.length,
                              itemBuilder: (context, index) {
                                var item = state.availableCities[index];
                                return _cityItem(
                                  title:
                                      "${item.name}, ${item.timezone}, ${item.country}",
                                  onTap: () => bloc.onShowWeatherDetail(item),
                                  onRemove: () => bloc.onRemoveCity(item),
                                );
                              },
                            )),
                        XSearchField(
                          value: state.searchText,
                          onChanged: (value) => bloc.onChangedText(value),
                          onSearch: () => bloc.onSearchCities(),
                          hinText:
                              "search which city you want to know its weather",
                        ),
                        Expanded(
                            flex: 1,
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
                                              onPressed: () =>
                                                  bloc.onAddCity(item),
                                              icon: const Icon(
                                                Icons.add,
                                              )),
                                        ],
                                      );
                                    },
                                  )),
                      ],
                    )));
          },
        ));
  }

  Widget _cityItem({
    required String title,
    void Function()? onTap,
    void Function()? onRemove,
  }) {
    return Row(
      children: [
        Expanded(
            child: GestureDetector(
          onTap: onTap,
          child: Text(title,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 18,
              )),
        )),
        IconButton(
            onPressed: onRemove,
            icon: Icon(
              Icons.delete,
              color: Colors.red.shade300,
            )),
      ],
    );
  }
}
