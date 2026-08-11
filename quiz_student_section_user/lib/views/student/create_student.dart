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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  List<SectionModel> sectionList = [];
  SectionModel? selectedSection;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    SectionService().getSections().then((val) {
      if (mounted) {
        setState(() => sectionList = val);
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _handleCreateStudent() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedSection == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a section")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await StudentService().createStudent(
        StudentModel(
          sectionId: selectedSection!.docId,
          studentName: nameController.text.trim(),
          studentCity: cityController.text.trim(),
          studentAge: int.parse(ageController.text.trim()),
          isPassed: false,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      if (!mounted) return;
      setState(() => isLoading = false);

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Success"),
          content: const Text("Student created successfully"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Student")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              TextFormField(
                controller: nameController,
                validator: (val) => val == null || val.isEmpty ? "Student name is required" : null,
                decoration: InputDecoration(
                  labelText: "Student Name",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: cityController,
                validator: (val) => val == null || val.isEmpty ? "City is required" : null,
                decoration: InputDecoration(
                  labelText: "City",
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                validator: (val) => val == null || int.tryParse(val) == null ? "Enter a valid age" : null,
                decoration: InputDecoration(
                  labelText: "Age",
                  prefixIcon: const Icon(Icons.numbers_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<SectionModel>(
                value: selectedSection,
                hint: const Text("Select Section"),
                validator: (val) => val == null ? "Section is required" : null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.class_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: sectionList.map((section) {
                  return DropdownMenuItem(
                    value: section,
                    child: Text(section.sectionName ?? ""),
                  );
                }).toList(),
                onChanged: (val) => setState(() => selectedSection = val),
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleCreateStudent,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                      : const Text("Create Student", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}