import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/student_model.dart';
import 'package:quiz_student_section_user/provider/user_provider.dart';
import 'package:quiz_student_section_user/services/student_service.dart';

class GetAllIntelligentStudents extends StatelessWidget {
  const GetAllIntelligentStudents({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.getUser().docId.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Intelligent Students")),
      body: StreamProvider<List<StudentModel>>.value(
        value: StudentService().getAllIntelligentStudents(userId),
        initialData: const [],
        builder: (context, child) {
          List<StudentModel> studentList = context.watch<List<StudentModel>>();

          if (studentList.isEmpty) {
            return const Center(
              child: Text(
                "No bookmarked students.",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final student = studentList[index];
              final isBookmarked = student.intelligent?.contains(userId) ?? false;

              return Card(
                elevation: 1,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber.withOpacity(0.15),
                    child: Icon(Icons.star, color: Colors.amber[800]),
                  ),
                  title: Text(student.studentName ?? "Unnamed", style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Age: ${student.studentAge ?? 'N/A'} • City: ${student.studentCity ?? 'N/A'}"),
                  trailing: IconButton(
                    icon: Icon(
                      isBookmarked ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: isBookmarked ? Colors.amber[700] : Colors.grey,
                    ),
                    onPressed: () async {
                      if (isBookmarked) {
                        await StudentService().removeFromIntelligentList(
                          userID: userId,
                          studentId: student.docId.toString(),
                        );
                      } else {
                        await StudentService().addToIntelligentList(
                          userID: userId,
                          studentId: student.docId.toString(),
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