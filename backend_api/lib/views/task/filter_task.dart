import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/services/task_service.dart';

class FilterTask extends StatefulWidget {
  const FilterTask({super.key});

  @override
  State<FilterTask> createState() => _FilterTaskState();
}

class _FilterTaskState extends State<FilterTask> {
  DateTime? _startDate;
  DateTime? _endDate;
  Future<TaskListingModel>? _filterFuture;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _applyFilter() {
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both Start and End dates")),
      );
      return;
    }

    final token = Provider.of<TokenProvider>(context, listen: false).getToken().toString();
    final startStr = _startDate!.toIso8601String().split('T')[0];
    final endStr = _endDate!.toIso8601String().split('T')[0];

    setState(() {
      _filterFuture = TaskService().filterTask(
        token: token,
        startDate: startStr,
        endDate: endStr,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter Tasks by Date"),
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
                    onPressed: () => _selectDate(context, true),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _startDate == null
                          ? "Start Date"
                          : _startDate!.toIso8601String().split('T')[0],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _selectDate(context, false),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _endDate == null
                          ? "End Date"
                          : _endDate!.toIso8601String().split('T')[0],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _applyFilter,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  child: const Text("Filter", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: _filterFuture == null
                ? const Center(child: Text("Select date range and tap Filter"))
                : FutureBuilder<TaskListingModel>(
              future: _filterFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final tasks = snapshot.data?.tasks;

                if (tasks == null || tasks.isEmpty) {
                  return const Center(child: Text("No tasks found in date range"));
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
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