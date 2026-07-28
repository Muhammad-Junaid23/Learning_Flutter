import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/city_model.dart';
import 'package:lecture_backend_crud/services/city_service.dart';
import 'package:lecture_backend_crud/views/city/create_cities.dart';
import 'package:lecture_backend_crud/views/city/update_city.dart';
import 'package:provider/provider.dart';

class GetAllVisitedCities extends StatelessWidget {
  const GetAllVisitedCities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Get All Visited Cities"),
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
        value: CityService().getAllVisitedCities(),
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        value: cityList[index].visited,
                        onChanged: (val)async{
                          try{
                            await CityService().markAsVisitedCities(
                                cityList[index].docId.toString(),
                                val!);
                          }catch(e){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                          }

                        }),
                    IconButton(onPressed: ()async{
                      try{
                        await CityService().deleteCity(
                            cityList[index].docId.toString()
                        ).then((value){
                          showDialog(context: context, builder: (BuildContext context) {
                            return
                              AlertDialog(
                                title: Text("Success"),
                                content: Text("City Deleted Successfully"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("OK"))
                                ],
                              );
                          });
                        });
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete, color: Colors.red,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateCity(model: cityList[index])));
                    }, icon: Icon(Icons.edit, color: Colors.blue,)),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}