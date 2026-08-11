import 'package:flutter/material.dart';
import 'package:quiz_student_section_user/models/section_model.dart';
import 'package:quiz_student_section_user/services/section_service.dart';

class CreateUpdateSection extends StatefulWidget {
  final SectionModel model;
  final bool isUpdateMode;

  const CreateUpdateSection({
    super.key,
    required this.model,
    required this.isUpdateMode,
  });

  @override
  State<CreateUpdateSection> createState() => _CreateUpdateSectionState();
}

class _CreateUpdateSectionState extends State<CreateUpdateSection> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.isUpdateMode ? widget.model.sectionName ?? "" : "",
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      if (widget.isUpdateMode) {
        await SectionService().updateSection(
          SectionModel(
            docId: widget.model.docId.toString(),
            sectionName: nameController.text.trim(),
          ),
        );
      } else {
        await SectionService().createSection(
          SectionModel(
            sectionName: nameController.text.trim(),
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      }

      if (!mounted) return;
      setState(() => isLoading = false);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Success"),
          content: Text(widget.isUpdateMode ? "Section updated successfully" : "Section created successfully"),
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
    final actionText = widget.isUpdateMode ? "Update Section" : "Create Section";

    return Scaffold(
      appBar: AppBar(title: Text(actionText)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              TextFormField(
                controller: nameController,
                validator: (val) => val == null || val.isEmpty ? "Section name is required" : null,
                decoration: InputDecoration(
                  labelText: "Section Name",
                  prefixIcon: const Icon(Icons.class_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isLoading
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                      : Text(actionText, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}