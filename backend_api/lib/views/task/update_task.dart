import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/provider/token_provider.dart';

class UpdateTask extends StatefulWidget {
  final Task model;
  const UpdateTask({super.key, required this.model});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late TextEditingController _descriptionController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.model.description ?? "");
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<TokenProvider>(context, listen: false).getToken().toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: "Description",
                prefixIcon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 20),
            _isSubmitting
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                setState(() => _isSubmitting = true);

                final success = await Provider.of<TaskProvider>(context, listen: false)
                    .updateTask(
                  token: token,
                  taskId: widget.model.id.toString(),
                  description: _descriptionController.text.trim(),
                );

                setState(() => _isSubmitting = false);

                if (mounted) {
                  if (success) {
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to update task")),
                    );
                  }
                }
              },
              child: const Text("Update Task"),
            ),
          ],
        ),
      ),
    );
  }
}