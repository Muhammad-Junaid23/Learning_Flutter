import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/provider/token_provider.dart';

class GetInCompletedTask extends StatelessWidget {
  const GetInCompletedTask({super.key});

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<TokenProvider>(context).getToken().toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Incompleted Tasks"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final incompletedTasks = taskProvider.incompletedTasks;

          if (incompletedTasks.isEmpty) {
            return RefreshIndicator(
              onRefresh: () => taskProvider.fetchAllTasks(token),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 100),
                  Center(child: Text("No incompleted tasks found")),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => taskProvider.fetchAllTasks(token),
            child: ListView.builder(
              itemCount: incompletedTasks.length,
              itemBuilder: (context, index) {
                final task = incompletedTasks[index];

                return ListTile(
                  leading: const Icon(Icons.radio_button_unchecked, color: Colors.orange),
                  title: Text(task.description ?? "No description"),
                  trailing: Checkbox(
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}