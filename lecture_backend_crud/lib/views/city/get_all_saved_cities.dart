import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/city_model.dart';
import 'package:lecture_backend_crud/provider/user_provider.dart';
import 'package:lecture_backend_crud/services/city_service.dart';
import 'package:lecture_backend_crud/views/city/create_cities.dart';
import 'package:lecture_backend_crud/views/city/get_all_remaining_cities.dart';
import 'package:lecture_backend_crud/views/city/get_all_visited_cities.dart';
import 'package:lecture_backend_crud/views/city/update_city.dart';
import 'package:provider/provider.dart';

class GetAllSavedCities extends StatelessWidget {
  const GetAllSavedCities({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text("All Saved Cities"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        // actions: [
        //   IconButton(onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllVisitedCities()));
        //   }, icon: Icon(Icons.circle)),
        //   IconButton(onPressed: (){
        //     Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllRemainingCities()));
        //   }, icon: Icon(Icons.incomplete_circle)),
        // ],
      ),
      body: StreamProvider.value(
        value: CityService().getAllSaved(userProvider.getUser().docId.toString()),
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
                    IconButton(onPressed: ()async{
                      if(cityList[index].saved!.contains(userProvider.getUser().docId.toString())){
                        await CityService().removeFromSaved(
                            userID: userProvider.getUser().docId.toString(),
                            cityID: cityList[index].docId.toString());
                      }
                      else{
                        await CityService().addToSaved(
                            userID: userProvider.getUser().docId.toString(),
                            cityID: cityList[index].docId.toString());
                      }
                    }, icon: Icon(cityList[index].saved!.contains(userProvider.getUser().docId.toString()) ? Icons.bookmark_sharp : Icons.bookmark_outline_sharp)),
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