import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/provider/user_provider.dart';
import 'package:lecture_backend_crud/services/city_service.dart';
import 'package:lecture_backend_crud/views/city/create_cities.dart';
import 'package:lecture_backend_crud/models/city_model.dart';
import 'package:lecture_backend_crud/views/city/get_all_remaining_cities.dart';
import 'package:lecture_backend_crud/views/city/get_all_saved_cities.dart';
import 'package:lecture_backend_crud/views/city/get_all_visited_cities.dart';
import 'package:lecture_backend_crud/views/city/update_city.dart';
import 'package:lecture_backend_crud/views/country/get_all_countries.dart';
import 'package:provider/provider.dart';


class GetAllCities extends StatelessWidget {
  const GetAllCities({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text("Get All Cities"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllVisitedCities()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllRemainingCities()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllSavedCities()));
          }, icon: Icon(Icons.bookmark_sharp)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllCountries()));
          }, icon: Icon(Icons.location_city)),
        ],
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
          // return ListView.builder(
          //   itemCount: cityList.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return ListTile(
          //       leading: Icon(Icons.task),
          //       title: Text(cityList[index].cityName.toString()),
          //       subtitle: Text(cityList[index].population.toString()),
          //       trailing: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Checkbox(
          //               value: cityList[index].visited,
          //               onChanged: (val)async{
          //                 try{
          //                   await CityService().markAsVisitedCities(
          //                       cityList[index].docId.toString(),
          //                       val!);
          //                 }catch(e){
          //                   ScaffoldMessenger.of(context)
          //                       .showSnackBar(SnackBar(content: Text(e.toString())));
          //                 }
          //
          //               }),
          //           IconButton(onPressed: ()async{
          //             try{
          //               await CityService().deleteCity(
          //                   cityList[index].docId.toString()
          //               ).then((value){
          //                 showDialog(context: context, builder: (BuildContext context) {
          //                   return
          //                     AlertDialog(
          //                       title: Text("Success"),
          //                       content: Text("City Deleted Successfully"),
          //                       actions: [
          //                         TextButton(onPressed: (){
          //                           Navigator.pop(context);
          //                         }, child: Text("OK"))
          //                       ],
          //                     );
          //                 });
          //               });
          //             }catch(e){
          //               ScaffoldMessenger.of(context)
          //                   .showSnackBar(SnackBar(content: Text(e.toString())));
          //             }
          //           }, icon: Icon(Icons.delete, color: Colors.red,)),
          //           IconButton(onPressed: (){
          //             Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateCity(model: cityList[index])));
          //           }, icon: Icon(Icons.edit, color: Colors.blue,)),
          //         ],
          //       ),
          //     );
          //   },);

          return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
              ),
              itemCount: cityList.length,
              itemBuilder: (BuildContext context, int index){
                  return Card(
                    elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(12),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          // ---------------- population ----------------
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                cityList[index].population.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                        // ---------------- City Icon ----------------
                          Icon(Icons.location_city,color: Colors.blue,size: 38,),

                          const SizedBox(height: 10),


                          // ---------------- City name ----------------

                          Text(cityList[index].cityName.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                            // textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 10),


                          // ------------------- visited -----------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(value: cityList[index].visited,
                                onChanged: (val)async{
                                  try{
                                    await CityService().markAsVisitedCities(
                                      cityList[index].docId.toString(),
                                      val!,
                                    );
                                  }catch (e){
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                },
                              ),
                              const Text("Visited"),
                            ],
                          ),

                          const Spacer(),

                          const Divider(
                            thickness: 1,
                          ),

                          // -------------- Actions -----------
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UpdateCity(
                                          model: cityList[index],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  // label: const Text("Edit"),
                                ),
                              ),

                              Container(
                                width: 1,
                                height: 30,
                                color: Colors.grey.shade300,
                              ),

                              Expanded(
                                child: IconButton(
                                  onPressed: () async {
                                    try {
                                      await CityService().deleteCity(
                                        cityList[index].docId.toString(),
                                      );

                                      if (!context.mounted) return;

                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Success"),
                                          content: const Text("City Deleted Successfully"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        ),
                                      );
                                    } catch (e) {
                                      if (!context.mounted) return;

                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(e.toString())),
                                      );
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  // label: const Text("Delete"),
                                ),
                              ),

                              Container(
                                width: 1,
                                height: 30,
                                color: Colors.grey.shade300,
                              ),

                              Expanded(
                                child: IconButton(
                                  onPressed: ()async{
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
                                  },
                                  icon:  Icon(cityList[index].saved!.contains(userProvider.getUser().docId.toString()) ? Icons.bookmark_sharp : Icons.bookmark_outline_sharp),
                                  // label: const Text("Save"),
                                ),
                              ),

                            ],
                          )

                        ],
                      ),

                      ),
                  );
              }
          );

        },
      ),
    );
  }
}