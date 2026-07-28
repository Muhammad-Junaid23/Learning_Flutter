import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/city_model.dart';
import 'package:lecture_backend_crud/services/city_service.dart';

class UpdateCity extends StatefulWidget {
  final CityModel model;
  const UpdateCity({super.key, required this.model});

  @override
  State<UpdateCity> createState() => _UpdateCityState();
}

class _UpdateCityState extends State<UpdateCity> {
  TextEditingController nameController = TextEditingController();
  TextEditingController populationController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.model.cityName.toString()
    );
    populationController = TextEditingController(
        text: widget.model.population.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update City"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "City Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: populationController,
            decoration: InputDecoration(
              hintText: "Population",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(
            child: CircularProgressIndicator(),
          ):
          ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await CityService().updateCity(
                  CityModel(
                    docId: widget.model.docId.toString(),
                    cityName: nameController.text.toString(),
                    population: int.parse(populationController.text),
                  )
              ).then((val){
                isLoading = false;
                setState(() {});
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("City Update Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("OK"))
                    ],
                  );
                }, );
              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Update City"))
        ],
      ),
    );
  }
}