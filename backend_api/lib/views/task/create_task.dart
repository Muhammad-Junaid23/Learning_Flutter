import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/provider/token_provider.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final TextEditingController _descriptionController = TextEditingController();
  bool _isSubmitting = false;

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
        title: const Text("Create Task"),
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
                hintText: "Task Description",
                prefixIcon: Icon(Icons.description),
              ),
            ),
            const SizedBox(height: 20),
            _isSubmitting
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                if (_descriptionController.text.trim().isEmpty) return;

                setState(() => _isSubmitting = true);

                final success = await Provider.of<TaskProvider>(context, listen: false)
                    .createTask(
                  token: token,
                  description: _descriptionController.text.trim(),
                );

                setState(() => _isSubmitting = false);

                if (mounted) {
                  if (success) {
                    Navigator.pop(context); // Close screen immediately
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Failed to create task")),
                    );
                  }
                }
              },
              child: const Text("Create Task"),
            ),
          ],
        ),
      ),
    );
  }
}