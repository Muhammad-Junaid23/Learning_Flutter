import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/services/student_service.dart';
import 'package:quiz_student_section_user/views/student/create_student.dart';

class GetAllPassedStudents extends StatelessWidget {
  const GetAllPassedStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passed Students")),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateStudent()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Student"),
      ),
      body: StreamProvider<List<StudentModel>>.value(
        value: StudentService().getAllPassedStudents(),
        initialData: const [],
        builder: (context, child) {
          List<StudentModel> studentList = context.watch<List<StudentModel>>();

          if (studentList.isEmpty) {
            return const Center(
              child: Text(
                "No passed students found.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final student = studentList[index];
              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.green.withOpacity(0.1),
                    child: const Icon(Icons.check, color: Colors.green),
                  ),
                  title: Text(student.studentName ?? "Unnamed", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Age: ${student.studentAge ?? 'N/A'} • City: ${student.studentCity ?? 'N/A'}"),
                  trailing: Checkbox(
                    value: student.isPassed ?? true,
                    activeColor: Colors.green,
                    onChanged: (val) async {
                      try {
                        await StudentService().markAsPassedStudent(
                          student.docId.toString(),
                          val ?? false,
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}