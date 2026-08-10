import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/services/student_service.dart';
import 'package:quiz_student_section_user/views/student/create_student.dart';

class GetAllFailedStudents extends StatelessWidget {
  const GetAllFailedStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Get All Failed Students"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateStudent()));
        },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: StudentService().getAllFailedStudents(),
        initialData: [StudentModel()],
        builder: (context, child){
          List<StudentModel> studentList = context.watch<List<StudentModel>>();
          return ListView.builder(
            itemCount: studentList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(studentList[index].studentName.toString()),
                subtitle: Text(studentList[index].studentAge.toString()),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                        value: studentList[index].isPassed,
                        onChanged: (val)async{
                          try{
                            await StudentService().markAsPassedStudent(
                                studentList[index].docId.toString(),
                                val!);
                          }catch(e){
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(e.toString())));
                          }

                        }),
                    // IconButton(onPressed: ()async{
                    //   try{
                    //     await CityService().deleteCity(
                    //         cityList[index].docId.toString()
                    //     ).then((value){
                    //       showDialog(context: context, builder: (BuildContext context) {
                    //         return
                    //           AlertDialog(
                    //             title: Text("Success"),
                    //             content: Text("City Deleted Successfully"),
                    //             actions: [
                    //               TextButton(onPressed: (){
                    //                 Navigator.pop(context);
                    //               }, child: Text("OK"))
                    //             ],
                    //           );
                    //       });
                    //     });
                    //   }catch(e){
                    //     ScaffoldMessenger.of(context)
                    //         .showSnackBar(SnackBar(content: Text(e.toString())));
                    //   }
                    // }, icon: Icon(Icons.delete, color: Colors.red,)),
                    // IconButton(onPressed: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateCity(model: cityList[index])));
                    // }, icon: Icon(Icons.edit, color: Colors.blue,)),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}