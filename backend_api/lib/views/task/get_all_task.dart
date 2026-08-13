import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/services/task_service.dart';
import 'package:backend_api/views/task/create_task.dart';
import 'package:backend_api/views/task/get_completed_task.dart';
import 'package:backend_api/views/task/get_incompleted_task.dart';
import 'package:backend_api/views/task/update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAllTask extends StatefulWidget {
  const GetAllTask({super.key});

  @override
  State<GetAllTask> createState() => _GetAllTaskState();
}

class _GetAllTaskState extends State<GetAllTask> {
  late Future<TaskListingModel> _tasksFuture;

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  void _fetchTasks() {
    final token = Provider.of<TokenProvider>(context, listen: false).getToken().toString();
    setState(() {
      _tasksFuture = TaskService().getAllTasks(token: token);
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
        title: const Text("Get All Task"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GetCompletedTask()),
              );
            },
            icon: const Icon(Icons.circle),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GetInCompletedTask()),
              );
            },
            icon: const Icon(Icons.incomplete_circle),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Await navigation so when user returns after creating a task, it auto-refreshes
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTask()),
          );
          _fetchTasks();
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshTask,
        child: FutureBuilder<TaskListingModel>(
          future: _tasksFuture,
          builder: (context, snapshot) {
            // 1. Handle Loading State
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. Handle Error State
            if (snapshot.hasError) {
              return Center(child: Text("Error loading tasks: ${snapshot.error}"));
            }

            // 3. Handle Null Data Safely (Fixes Red Screen)
            final taskListingModel = snapshot.data;
            final tasks = taskListingModel?.tasks;

            if (tasks == null || tasks.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 100),
                  Center(child: Text("No tasks found")),
                ],
              );
            }

            // 4. Render Tasks List
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
                      // --- TOGGLE CHECKBOX ---
                      Checkbox(
                        value: task.complete ?? false,
                        onChanged: (bool? value) async {
                          if (value == null) return;

                          // Optimistically update UI state immediately
                          setState(() {
                            tasks[index] = task.copyWith(complete: value);
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
                            // Revert back on failure
                            setState(() {
                              tasks[index] = task.copyWith(complete: !value);
                            });

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        },
                      ),

                      // --- DELETE TASK ---
                      IconButton(
                        onPressed: () async {
                          final deletedTask = tasks[index];

                          // Remove locally immediately for smooth UI UX
                          setState(() {
                            tasks.removeAt(index);
                          });

                          try {
                            await TaskService().deleteTask(
                              token: tokenProvider.getToken().toString(),
                              taskId: deletedTask.id.toString(),
                            );
                          } catch (e) {
                            // Reinsert on failure
                            setState(() {
                              tasks.insert(index, deletedTask);
                            });

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.delete),
                      ),

                      // --- UPDATE TASK ---
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateTask(model: task),
                            ),
                          );
                          _fetchTasks(); // Refresh list after returning from update screen
                        },
                        icon: const Icon(Icons.edit),
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