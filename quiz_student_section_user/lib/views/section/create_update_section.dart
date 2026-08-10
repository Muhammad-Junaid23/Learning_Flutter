import 'package:flutter/material.dart';
import 'package:quiz_student_section_user/models/section_model.dart';
import 'package:quiz_student_section_user/services/section_service.dart';

class CreateUpdateSection extends StatefulWidget {
  final SectionModel model;
  final bool isUpdateMode;
  const CreateUpdateSection({super.key, required this.model, required this.isUpdateMode});

  @override
  State<CreateUpdateSection> createState() => _CreateUpdateSectionState();
}

class _CreateUpdateSectionState extends State<CreateUpdateSection> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState(){
    super.initState();
    if(widget.isUpdateMode == true){
      nameController = TextEditingController(
          text: widget.model.sectionName.toString()
      );
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateMode == true ? "Update Section" : "Create Section"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Section Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          isLoading ? Center(child: CircularProgressIndicator(),)
              :ElevatedButton(onPressed: ()async{
            try{
              if(widget.isUpdateMode == true){
                await SectionService().updateSection(
                    SectionModel(
                      docId: widget.model.docId.toString(),
                      sectionName: nameController.text.toString(),
                    )
                ).then((value){
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Success"),
                      content: Text("Section Updated Successfully"),
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
              else{
                await SectionService().createSection(
                    SectionModel(
                        sectionName: nameController.text.toString(),
                        createdAt: DateTime.now().millisecondsSinceEpoch
                    )
                ).then((value){
                  showDialog(context: context, builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Success"),
                      content: Text("Section created Successfully"),
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
              child: Text(widget.isUpdateMode ? "Update Section" : "Create Section"))
        ],
      ),
    );
  }
}
