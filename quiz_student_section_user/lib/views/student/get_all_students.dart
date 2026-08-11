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
    final userProvider = Provider.of<UserProvider>(context);
    final userId = userProvider.getUser().docId.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        actions: [
          IconButton(
            tooltip: "Passed Students",
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GetAllPassedStudents()),
              );
            },
          ),
          IconButton(
            tooltip: "Failed Students",
            icon: const Icon(Icons.highlight_off_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GetAllFailedStudents()),
              );
            },
          ),
          IconButton(
            tooltip: "Intelligent Students",
            icon: const Icon(Icons.star_outline_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GetAllIntelligentStudents()),
              );
            },
          ),
          IconButton(
            tooltip: "Sections",
            icon: const Icon(Icons.domain_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GetAllSections()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateStudent()),
          );
        },
        icon: const Icon(Icons.person_add_outlined),
        label: const Text("Add Student"),
      ),
      body: StreamProvider<List<StudentModel>>.value(
        value: StudentService().getAllStudents(),
        initialData: const [],
        builder: (context, child) {
          List<StudentModel> studentList = context.watch<List<StudentModel>>();

          if (studentList.isEmpty) {
            return const Center(
              child: Text(
                "No students added yet.\nTap '+' to add a new student.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final student = studentList[index];
              final isBookmarked = student.intelligent?.contains(userId) ?? false;
              final isPassed = student.isPassed ?? false;

              return Card(
                elevation: 1.5,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                            child: Icon(Icons.person, color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.studentName ?? "Unnamed",
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "City: ${student.studentCity ?? 'N/A'} • Age: ${student.studentAge ?? 'N/A'}",
                                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isPassed ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              isPassed ? "Passed" : "Pending",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isPassed ? Colors.green[800] : Colors.orange[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isPassed,
                                activeColor: Colors.green,
                                onChanged: (val) async {
                                  try {
                                    await StudentService().markAsPassedStudent(
                                      student.docId.toString(),
                                      val ?? false,
                                    );
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                },
                              ),
                              const Text("Passed Status", style: TextStyle(fontSize: 13)),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                tooltip: "Mark Intelligent",
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
                              IconButton(
                                tooltip: "Edit",
                                icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => UpdateStudent(model: student)),
                                  );
                                },
                              ),
                              IconButton(
                                tooltip: "Delete",
                                icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                                onPressed: () async {
                                  try {
                                    await StudentService().deleteStudent(student.docId.toString());
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Student deleted successfully")),
                                    );
                                  } catch (e) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString())),
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      )
                    ],
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