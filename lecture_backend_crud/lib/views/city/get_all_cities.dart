import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/views/city/create_cities.dart';
import 'package:lecture_backend_crud/models/city_model.dart';
import 'package:lecture_backend_crud/services/city_service.dart';
import 'package:provider/provider.dart';

class GetAllCities extends StatelessWidget {
  const GetAllCities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Get All Cities"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateCities()));
        },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: CityService().getAllCities(),
        initialData: [CityModel()],
        builder: (context, child){
          List<CityModel> cityList = context.watch<List<CityModel>>();
          return ListView.builder(
            itemCount: cityList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(cityList[index].cityName.toString()),
                subtitle: Text(cityList[index].population.toString()),
              );
            },);
        },
      ),
    );
  }
}