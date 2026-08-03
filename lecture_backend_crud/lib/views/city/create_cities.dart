import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/city_model.dart';
import 'package:lecture_backend_crud/models/country_model.dart';
import 'package:lecture_backend_crud/services/city_service.dart';
import 'package:lecture_backend_crud/services/country_service.dart';

class CreateCities extends StatefulWidget {
  const CreateCities({super.key});

  @override
  State<CreateCities> createState() => _CreateCitiesState();
}

class _CreateCitiesState extends State<CreateCities> {
  TextEditingController nameController = TextEditingController();
  TextEditingController populationController = TextEditingController();
  List<CountryModel> countryList = [];
  CountryModel? selectedCountry;

  @override
  void initState() {
    super.initState();
    CountryService().getCountries().then((val){
      setState((){
        countryList = val;
      });
    });
  }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   populationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Cities"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "City name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: populationController,
            decoration: InputDecoration(
                hintText: "Population",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          SizedBox(height: 10,),
          DropdownButton(
              hint: Text("Select country"),
              value: selectedCountry,
              items: countryList.map((country){
                return DropdownMenuItem(
                    value: country,
                    child: Text(country.countryName.toString())
                );
              }).toList(),
              onChanged: (val){
                setState(() {
                  selectedCountry = val;
                });
              }),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: ()async{
            try{
              await CityService().createCity(
                CityModel(
                  countryID: selectedCountry!.docId,
                  cityName: nameController.text.toString(),
                  population: int.parse(populationController.text),
                  visited: false,
                  createdAt: DateTime.now().millisecondsSinceEpoch
                )
              );

                  // showDialog(context: context,
                  //     builder: (BuildContext dialogContext){
                  //   return AlertDialog(
                  //     title: Text("Success"),
                  //     content: Text("City created Successfully"),
                  //     actions: [
                  //       TextButton(onPressed: (){
                  //         Navigator.pop(dialogContext);
                  //         Navigator.pop(context);
                  //       }, child: Text("OK"))
                  //     ],
                  //   );
                  //     },
                  // );

              if (!mounted) return;

              await showDialog(
                context: this.context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("City created Successfully"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );

              if (!mounted) return;

              Navigator.pop(this.context);

            }
            catch(e){
              if (!mounted) return;
              ScaffoldMessenger.of(this.context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Create City"))
        ],
      ),
    );
  }
}
