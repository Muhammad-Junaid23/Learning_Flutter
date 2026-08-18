import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/services/task_service.dart';
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
  Widget build(BuildContext context) {
    final token = Provider.of<TokenProvider>(context).getToken().toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Tasks"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchTask()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FilterTask()),
            ),
          ),
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
          if (taskProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (taskProvider.errorMessage != null) {
            return Center(child: Text("Error: ${taskProvider.errorMessage}"));
          }

          if (taskProvider.tasks.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => taskProvider.fetchAllTasks(token),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 100),
                  Center(child: Text("No tasks found")),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => taskProvider.fetchAllTasks(token),
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];

                return ListTile(
                  leading: const Icon(Icons.task),
                  title: Text(task.description ?? "No description"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Toggle Checkbox
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
                      // Delete Action
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => taskProvider.deleteTask(
                          token: token,
                          taskId: task.id.toString(),
                        ),
                      ),
                      // Edit Action
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
          );
        },
      ),
    );
  }
}