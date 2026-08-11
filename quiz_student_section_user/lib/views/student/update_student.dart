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
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController cityController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.model.studentName ?? "");
    ageController = TextEditingController(text: widget.model.studentAge?.toString() ?? "");
    cityController = TextEditingController(text: widget.model.studentCity ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void _handleUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await StudentService().updateStudent(
        StudentModel(
          docId: widget.model.docId.toString(),
          studentName: nameController.text.trim(),
          studentAge: int.parse(ageController.text.trim()),
          studentCity: cityController.text.trim(),
        ),
      );

      if (!mounted) return;
      setState(() => isLoading = false);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Success"),
          content: const Text("Student details updated successfully"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        ),
      );
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
      appBar: AppBar(title: const Text("Update Student")),
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
                validator: (val) => val == null || val.isEmpty ? "Name is required" : null,
                decoration: InputDecoration(
                  labelText: "Student Name",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                validator: (val) => val == null || int.tryParse(val) == null ? "Enter a valid age" : null,
                decoration: InputDecoration(
                  labelText: "Student Age",
                  prefixIcon: const Icon(Icons.numbers_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: cityController,
                validator: (val) => val == null || val.isEmpty ? "City is required" : null,
                decoration: InputDecoration(
                  labelText: "Student City",
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleUpdate,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                      : const Text("Update Student", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}