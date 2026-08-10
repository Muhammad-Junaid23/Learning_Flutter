import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/provider/user_provider.dart';
import 'package:quiz_student_section_user/services/student_service.dart';

class GetAllIntelligentStudents extends StatelessWidget {
  const GetAllIntelligentStudents({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text("All Intelligent Students"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: StreamProvider.value(
        value: StudentService().getAllIntelligentStudents(userProvider.getUser().docId.toString()),
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
                    IconButton(onPressed: ()async{
                      if(studentList[index].intelligent!.contains(userProvider.getUser().docId.toString())){
                        await StudentService().removeFromIntelligentList(
                            userID: userProvider.getUser().docId.toString(),
                            studentId: studentList[index].docId.toString());
                      }
                      else{
                        await StudentService().addToIntelligentList(
                            userID: userProvider.getUser().docId.toString(),
                            studentId: studentList[index].docId.toString());
                      }
                    }, icon: Icon(studentList[index].intelligent!.contains(userProvider.getUser().docId.toString()) ? Icons.bookmark_sharp : Icons.bookmark_outline_sharp)),


                    // Checkbox(
                    //     value: cityList[index].visited,
                    //     onChanged: (val)async{
                    //       try{
                    //         await CityService().markAsVisitedCities(
                    //             cityList[index].docId.toString(),
                    //             val!);
                    //       }catch(e){
                    //         ScaffoldMessenger.of(context)
                    //             .showSnackBar(SnackBar(content: Text(e.toString())));
                    //       }
                    //
                    //     }),
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