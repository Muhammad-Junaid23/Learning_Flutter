import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/services/task_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetCompletedTask extends StatefulWidget {
  const GetCompletedTask({super.key});

  @override
  State<GetCompletedTask> createState() => _GetCompletedTaskState();
}

class _GetCompletedTaskState extends State<GetCompletedTask> {
  late Future<TaskListingModel> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() {
    final token = Provider.of<TokenProvider>(context, listen: false).getToken().toString();
    setState(() {
      _tasksFuture = TaskService().getCompletedTasks(token: token);
    });
  }

  Future<void> _refreshTask() async {
    _fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider = Provider.of<TokenProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Completed Task"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTask,
        child: FutureBuilder<TaskListingModel>(
          future: _tasksFuture,
          builder: (context, snapshot) {
            // 1. Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Error state
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            // 3. Null and empty check (Fixes Red Screen)
            final taskListingModel = snapshot.data;
            final tasks = taskListingModel?.tasks;

            if (tasks == null || tasks.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 100),
                  Center(child: Text("No completed tasks found")),
                ],
              );
            }

            // 4. Render list
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final task = tasks[index];

                return ListTile(
                  leading: const Icon(Icons.task),
                  title: Text(task.description ?? "No description"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: task.complete ?? true,
                        onChanged: (bool? value) async {
                          if (value == null) return;

                          // Remove task locally from completed list if marked incomplete
                          final toggledTask = tasks[index];
                          setState(() {
                            tasks.removeAt(index);
                          });

                          try {
                            final token = tokenProvider.getToken().toString();
                            final taskId = task.id.toString();

                            if (value) {
                              await TaskService().markTaskAsCompleted(
                                token: token,
                                taskId: taskId,
                              );
                            } else {
                              await TaskService().markTaskAsIncompleted(
                                token: token,
                                taskId: taskId,
                              );
                            }
                          } catch (e) {
                            // Revert on network failure
                            setState(() {
                              tasks.insert(index, toggledTask);
                            });

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}