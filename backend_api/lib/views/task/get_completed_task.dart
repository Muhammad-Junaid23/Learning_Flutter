import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetCompletedTask extends StatelessWidget {
  const GetCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<TokenProvider>(context).getToken().toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Tasks"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final completedTasks = taskProvider.completedTasks;

          if (completedTasks.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => taskProvider.fetchAllTasks(token),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 100),
                  Center(child: Text("No completed tasks found")),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => taskProvider.fetchAllTasks(token),
            child: ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                final task = completedTasks[index];

                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: Text(task.description ?? "No description"),
                  trailing: Checkbox(
                    value: task.complete ?? true,
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}