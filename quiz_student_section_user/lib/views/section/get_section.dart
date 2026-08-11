import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/section_model.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/services/student_service.dart';
import 'package:quiz_student_section_user/views/student/create_student.dart';

class GetSection extends StatelessWidget {
  final SectionModel model;
  const GetSection({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.sectionName ?? "Section Details"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateStudent()),
          );
        },
        icon: const Icon(Icons.person_add),
        label: const Text("Add Student"),
      ),
      body: StreamProvider<List<StudentModel>>.value(
        value: StudentService().getStudentBySectionID(model.docId.toString()),
        initialData: const [],
        builder: (context, child) {
          List<StudentModel> studentList = context.watch<List<StudentModel>>();

          if (studentList.isEmpty) {
            return const Center(
              child: Text(
                "No students enrolled in this section.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final student = studentList[index];
              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.withOpacity(0.1),
                    child: const Icon(Icons.school, color: Colors.teal),
                  ),
                  title: Text(
                    student.studentName ?? "Unnamed",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("City: ${student.studentCity ?? 'N/A'}"),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Age: ${student.studentAge ?? 'N/A'}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
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