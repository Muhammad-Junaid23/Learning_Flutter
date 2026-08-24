import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/services/task_service.dart';
import 'package:backend_api/views/profile/get_profile.dart';
import 'package:backend_api/views/task/create_task.dart';
import 'package:backend_api/views/task/filter_task.dart';
import 'package:backend_api/views/task/get_completed_task.dart';
import 'package:backend_api/views/task/get_incompleted_task.dart';
import 'package:backend_api/views/task/search_task.dart';
import 'package:backend_api/views/task/update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatefulWidget {
  const GetAllTask({super.key});

  @override
  State<GetAllTask> createState() => _GetAllTaskState();
}

class _GetAllTaskState extends State<GetAllTask> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final token = Provider.of<TokenProvider>(context, listen: false).getToken();
      if (token != null) {
        Provider.of<TaskProvider>(context, listen: false).fetchAllTasks(token);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Show Date Picker Dialog for Filtering
  void _showFilterDialog(BuildContext context) {
    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text("Filter Tasks by Date"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(startDate == null
                        ? "Select Start Date"
                        : startDate!.toIso8601String().split('T')[0]),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setDialogState(() => startDate = picked);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.calendar_today),
                    title: Text(endDate == null
                        ? "Select End Date"
                        : endDate!.toIso8601String().split('T')[0]),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setDialogState(() => endDate = picked);
                      }
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (startDate != null && endDate != null) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .filterByDateRange(startDate!, endDate!);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Filter"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<TokenProvider>(context).getToken().toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Tasks"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.circle),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GetCompletedTask()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.incomplete_circle),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GetInCompletedTask()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GetProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CreateTask()),
        ),
        child: const Icon(Icons.add),
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final tasks = taskProvider.displayedTasks;

          return Column(
            children: [
              // --- INLINE SEARCH & FILTER BAR ---
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search task...",
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              taskProvider.searchInMemory("");
                            },
                          )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (val) => taskProvider.searchInMemory(val),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.filter_list, size: 30),
                      onPressed: () => _showFilterDialog(context),
                    ),
                  ],
                ),
              ),

              // --- RESET BUTTON BAR (Visible when active search/filter exists) ---
              if (taskProvider.isFilteredOrSearched)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Showing filtered results",
                        style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                      ),
                      ActionChip(
                        avatar: const Icon(Icons.refresh, size: 16),
                        label: const Text("Reset to All"),
                        onPressed: () {
                          _searchController.clear();
                          taskProvider.resetFilters();
                        },
                      ),
                    ],
                  ),
                ),

              // --- TASK LIST / EMPTY STATE ---
              Expanded(
                child: taskProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : tasks.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No tasks found"),
                      const SizedBox(height: 10),
                      if (taskProvider.isFilteredOrSearched)
                        ElevatedButton(
                          onPressed: () {
                            _searchController.clear();
                            taskProvider.resetFilters();
                          },
                          child: const Text("Clear Search / Filters"),
                        ),
                    ],
                  ),
                )
                    : RefreshIndicator(
                  onRefresh: () => taskProvider.fetchAllTasks(token),
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return ListTile(
                        leading: const Icon(Icons.task),
                        title: Text(task.description ?? "No description"),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              value: task.complete ?? false,
                              onChanged: (bool? val) {
                                if (val != null) {
                                  taskProvider.toggleTaskStatus(
                                    token: token,
                                    task: task,
                                    isCompleted: val,
                                  );
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => taskProvider.deleteTask(
                                token: token,
                                taskId: task.id.toString(),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UpdateTask(model: task),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}