import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_student_section_user/models/section_model.dart';
import 'package:quiz_student_section_user/services/section_service.dart';
import 'package:quiz_student_section_user/views/profile/get_profile.dart';
import 'package:quiz_student_section_user/views/section/create_update_section.dart';
import 'package:quiz_student_section_user/views/section/get_section.dart';

class GetAllSections extends StatelessWidget {
  const GetAllSections({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sections"),
        actions: [
          IconButton(
            tooltip: "User Profile",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GetProfile()),
              );
            },
            icon: const Icon(Icons.account_circle_outlined, size: 28),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUpdateSection(
                model: SectionModel(),
                isUpdateMode: false,
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Section"),
      ),
      body: StreamProvider<List<SectionModel>>.value(
        value: SectionService().getAllSections(),
        initialData: const [],
        builder: (context, child) {
          List<SectionModel> sectionList = context.watch<List<SectionModel>>();

          if (sectionList.isEmpty) {
            return const Center(
              child: Text(
                "No sections available.\nTap '+' to create one.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: sectionList.length,
            itemBuilder: (context, index) {
              final section = sectionList[index];
              return Card(
                elevation: 1.5,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Icon(Icons.class_, color: Theme.of(context).primaryColor),
                  ),
                  title: Text(
                    section.sectionName ?? "Unnamed Section",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateUpdateSection(
                                isUpdateMode: true,
                                model: section,
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () async {
                          try {
                            await SectionService().deleteSection(section.docId.toString());
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GetSection(model: section),
                            ),
                          );
                        },
                      ),
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