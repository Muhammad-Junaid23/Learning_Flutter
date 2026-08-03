import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/city_model.dart';
import 'package:lecture_backend_crud/models/country_model.dart';
import 'package:lecture_backend_crud/services/city_service.dart';
import 'package:provider/provider.dart';

class GetCountry extends StatelessWidget {
  final CountryModel model;
  const GetCountry({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.countryName}"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider<List<CityModel>>.value(
          value: CityService().getCityByCountryID(model.docId.toString()),
          initialData: [],
          builder: (context,child){
            List<CityModel> cityList = context.watch<List<CityModel>>();
            return ListView.builder(
                itemCount: cityList.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: Icon(Icons.flag),
                    title: Text(cityList[index].cityName.toString()),
                    subtitle: Text(cityList[index].population.toString()),
                  );
                },
            );
          },
      ),
    );
  }
}
