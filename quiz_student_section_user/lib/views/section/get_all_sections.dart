import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/section_model.dart';
import 'package:quiz_student_section_user/services/section_service.dart';
import 'package:quiz_student_section_user/views/section/create_update_section.dart';
import 'package:quiz_student_section_user/views/section/get_section.dart';
import 'package:quiz_student_section_user/views/student/get_all_students.dart';

class GetAllSections extends StatelessWidget {
  const GetAllSections({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("All Sections"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllStudents()));
          }, icon: Icon(Icons.account_circle)),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateSection(model: SectionModel(),isUpdateMode: false,)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: SectionService().getAllSections(),
        initialData: [SectionModel()],
        builder: (context, child){
          List<SectionModel> sectionList = context.watch<List<SectionModel>>();
          return ListView.builder(
            itemCount: sectionList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(sectionList[index].sectionName.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      try{
                        await SectionService().deleteSection(
                            sectionList[index].docId.toString()
                        );
                      }catch(e){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateUpdateSection(isUpdateMode: true, model: sectionList[index],)));
                    }, icon: Icon(Icons.edit,color: Colors.blue,)),
                    IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetSection(model: sectionList[index])));
                    }, icon: Icon(Icons.arrow_forward,color: Colors.green,)),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}
