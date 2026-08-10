import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/provider/user_provider.dart';
import 'package:quiz_student_section_user/services/student_service.dart';
import 'package:quiz_student_section_user/views/section/get_all_sections.dart';
import 'package:quiz_student_section_user/views/student/create_student.dart';
import 'package:quiz_student_section_user/views/student/get_all_failed_students.dart';
import 'package:quiz_student_section_user/views/student/get_all_intelligent_students.dart';
import 'package:quiz_student_section_user/views/student/get_all_passed_students.dart';
import 'package:quiz_student_section_user/views/student/update_student.dart';


class GetAllStudents extends StatelessWidget {
  const GetAllStudents({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar:AppBar(
        title: Text("Get All Students"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllPassedStudents()));
          }, icon: Icon(Icons.circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllFailedStudents()));
          }, icon: Icon(Icons.incomplete_circle)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllIntelligentStudents()));
          }, icon: Icon(Icons.bookmark_sharp)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> GetAllSections()));
          }, icon: Icon(Icons.location_city)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateStudent()));
        },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: StudentService().getAllStudents(),
        initialData: [StudentModel()],
        builder: (context, child){
          List<StudentModel> studentList = context.watch<List<StudentModel>>();
          return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: studentList.length,
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
                              studentList[index].studentAge.toString(),
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

                        Text(studentList[index].studentName.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          // textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 10),

                        // ---------------- student City ----------------

                        Text(studentList[index].studentCity.toString(),
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
                            Checkbox(value: studentList[index].isPassed,
                              onChanged: (val)async{
                                try{
                                  await StudentService().markAsPassedStudent(
                                    studentList[index].docId.toString(),
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
                            const Text("Passed"),
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
                                      builder: (_) => UpdateStudent(
                                        model: studentList[index],
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
                                    await StudentService().deleteStudent(
                                      studentList[index].docId.toString(),
                                    );

                                    if (!context.mounted) return;

                                    showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                        title: const Text("Success"),
                                        content: const Text("student Deleted Successfully"),
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
                                },
                                icon:  Icon(studentList[index].intelligent!.contains(userProvider.getUser().docId.toString()) ? Icons.bookmark_sharp : Icons.bookmark_outline_sharp),
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