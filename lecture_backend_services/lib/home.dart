import 'package:flutter/material.dart';
import 'package:lecture_backend_services/services/city_services.dart';

import 'models/city_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Services"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Testing Firebase"),
            ElevatedButton(
              onPressed: () async {

                CityModel city = CityModel(
                  cityName: "Rawalpindi",
                  population: 2500000,
                  visited: false,
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                );

                await CityServices().createCity(city);

                print("City Added");

              },
              child: const Text("Create City"),
            ),
            Expanded(
              child: StreamBuilder<List<CityModel>>(
                stream: CityServices().getAllCities(),
                builder: (context, snapshot) {

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No Cities Found"),
                    );
                  }

                  List<CityModel> cities = snapshot.data!;

                  return ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, index) {

                      CityModel city = cities[index];

                      return ListTile(
                        title: Text(city.cityName ?? ""),
                        subtitle: Text(city.population.toString()),
                      );
                    },
                  );
                },
              ),
            )
          ],
        )
      ),
    );
  }
}