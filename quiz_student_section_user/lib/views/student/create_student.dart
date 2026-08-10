import 'package:flutter/material.dart';
import 'package:quiz_student_section_user/models/section_model.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/services/section_service.dart';
import 'package:quiz_student_section_user/services/student_service.dart';

class CreateStudent extends StatefulWidget {
  const CreateStudent({super.key});

  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<SectionModel> sectionList = [];
  SectionModel? selectedSection;

  @override
  void initState() {
    super.initState();
    SectionService().getSections().then((val){
      setState((){
        sectionList = val;
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
        title: Text("Create Student"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: "Student name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: cityController,
            decoration: InputDecoration(
                hintText: "Student city",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: ageController,
            decoration: InputDecoration(
                hintText: "Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
            ),
          ),
          SizedBox(height: 10,),
          DropdownButton(
              hint: Text("Select Section"),
              value: selectedSection,
              items: sectionList.map((section){
                return DropdownMenuItem(
                    value: section,
                    child: Text(section.sectionName.toString())
                );
              }).toList(),
              onChanged: (val){
                setState(() {
                  selectedSection = val;
                });
              }),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: ()async{
            try{
              await StudentService().createStudent(
                  StudentModel(
                      sectionId: selectedSection!.docId,
                      studentName: nameController.text.toString(),
                      studentCity: cityController.text.toString(),
                      studentAge: int.parse(ageController.text),
                      isPassed: false,
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
                    content: Text("Student created Successfully"),
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
          }, child: Text("Create Student"))
        ],
      ),
    );
  }
}