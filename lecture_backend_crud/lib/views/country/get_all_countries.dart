import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/country_model.dart';
import 'package:lecture_backend_crud/services/country_service.dart';
import 'package:lecture_backend_crud/views/country/create_update_country.dart';
// import 'package:lecture_backend_crud/views/country/create_update_country.dart';
import 'package:provider/provider.dart';

class GetAllCountries extends StatelessWidget {
  const GetAllCountries({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Countries"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateCountry(model: CountryModel(),isUpdateMode: false,)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: CountryService().getAllCountries(),
        initialData: [CountryModel()],
        builder: (context, child){
          List<CountryModel> countryList = context.watch<List<CountryModel>>();
          return ListView.builder(
            itemCount: countryList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(countryList[index].countryName.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      try{
                        await CountryService().deleteCountry(
                            countryList[index].docId.toString()
                        );
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateCountry(isUpdateMode: true, model: countryList[index],)));
                    }, icon: Icon(Icons.edit,color: Colors.blue,)),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}