import 'package:flutter/material.dart';
import 'package:lecture_backend_crud/models/country_model.dart';
import 'package:lecture_backend_crud/services/country_service.dart';

class CreateUpdateCountry extends StatefulWidget {
  final CountryModel model;
  final bool isUpdateMode;
  const CreateUpdateCountry({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreateUpdateCountry> createState() => _CreateUpdateCountryState();
}

class _CreateUpdateCountryState extends State<CreateUpdateCountry> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    if(widget.isUpdateMode == true){
      nameController = TextEditingController(
        text: widget.model.countryName.toString()
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode == true ? "Update Country" : "Create Country"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Country Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              if(widget.isUpdateMode == true){
                await CountryService().updateCountry(
                    CountryModel(
                      docId: widget.model.docId.toString(),
                      countryName: nameController.text.toString(),
                    )
                ).then((value){
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Success"),
                      content: Text("Country Updated Successfully"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: Text("OK"))
                      ],
                    );
                  }, );
                });
              }
              else{
                await CountryService().createCountry(
                    CountryModel(
                        countryName: nameController.text.toString(),
                        createdAt: DateTime.now().millisecondsSinceEpoch
                    )
                ).then((value){
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Success"),
                      content: Text("Country Updated Successfully"),
                      actions: [
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, child: Text("OK"))
                      ],
                    );
                  }, );
                });
              }
            }catch(e){
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
              child: Text(widget.isUpdateMode ? "Update Country" : "Create Country"))
        ],
      ),
    );
  }
}