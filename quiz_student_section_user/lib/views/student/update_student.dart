import 'package:flutter/material.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/services/student_service.dart';

class UpdateStudent extends StatefulWidget {
  final StudentModel model;
  const UpdateStudent({super.key, required this.model});

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.model.studentName.toString()
    );
    ageController = TextEditingController(
        text: widget.model.studentAge.toString()
    );
    cityController = TextEditingController(
        text: widget.model.studentCity.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update City"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Student Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: ageController,
            decoration: InputDecoration(
              hintText: "Student Age",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: cityController,
            decoration: InputDecoration(
              hintText: "Student City",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 10,),
          isLoading ? Center(
            child: CircularProgressIndicator(),
          ):
          ElevatedButton(onPressed: ()async{
            try{
              isLoading = true;
              setState(() {});
              await StudentService().updateStudent(
                  StudentModel(
                    docId: widget.model.docId.toString(),
                    studentName: nameController.text.toString(),
                    studentAge: int.parse(ageController.text),
                    studentCity: cityController.text.toString(),
                  )
              ).then((val){
                setState(() {
                  isLoading = false;
                });
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("Student Updated Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }, child: Text("OK"))
                    ],
                  );
                }, );
              });
            }catch(e){
              isLoading = false;
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Update Student"))
        ],
      ),
    );
  }
}