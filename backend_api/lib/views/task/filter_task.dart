import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/provider/token_provider.dart';

class FilterTask extends StatefulWidget {
  const FilterTask({super.key});

  @override
  State<FilterTask> createState() => _FilterTaskState();
}

class _FilterTaskState extends State<FilterTask> {
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) _startDate = picked;
        else _endDate = picked;
      });
    }
  }

  void _applyFilter(String token) {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both dates")),
      );
      return;
    }

    final startStr = _startDate!.toIso8601String().split('T')[0];
    final endStr = _endDate!.toIso8601String().split('T')[0];

    Provider.of<TaskProvider>(context, listen: false).filterTasksByDate(
      token: token,
      startDate: startStr,
      endDate: endStr,
    );
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<TokenProvider>(context).getToken().toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Tasks"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pickDate(context, true),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_startDate == null ? "Start Date" : _startDate!.toIso8601String().split('T')[0]),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _pickDate(context, false),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(_endDate == null ? "End Date" : _endDate!.toIso8601String().split('T')[0]),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _applyFilter(token),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  child: const Text("Filter", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                if (taskProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (taskProvider.filteredResults.isEmpty) {
                  return const Center(child: Text("No tasks in selected range"));
                }

                return ListView.builder(
                  itemCount: taskProvider.filteredResults.length,
                  itemBuilder: (context, index) {
                    final task = taskProvider.filteredResults[index];
                    return ListTile(
                      leading: const Icon(Icons.task),
                      title: Text(task.description ?? "No description"),
                      subtitle: Text("Created: ${task.createdAt ?? 'N/A'}"),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}