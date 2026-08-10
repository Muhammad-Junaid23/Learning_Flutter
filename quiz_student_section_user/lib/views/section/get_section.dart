import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/section_model.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/services/student_service.dart';

class GetSection extends StatelessWidget {
  final SectionModel model;
  const GetSection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.sectionName}"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider<List<StudentModel>>.value(
        value: StudentService().getStudentBySectionID(model.docId.toString()),
        initialData: [],
        builder: (context,child){
          List<StudentModel> studentList = context.watch<List<StudentModel>>();
          return ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                leading: Icon(Icons.flag),
                title: Text(studentList[index].studentName.toString()),
                subtitle: Text(studentList[index].studentCity.toString()),
                trailing: Text(studentList[index].studentAge.toString()),
              );
            },
          );
        },
      ),
    );
  }
}