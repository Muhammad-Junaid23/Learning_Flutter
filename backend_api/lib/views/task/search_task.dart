import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backend_api/models/task_model.dart';
import 'package:backend_api/provider/token_provider.dart';
import 'package:backend_api/services/task_service.dart';

class SearchTask extends StatefulWidget {
  const SearchTask({super.key});

  @override
  State<SearchTask> createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTask> {
  final TextEditingController _searchController = TextEditingController();
  Future<TaskListingModel>? _searchFuture;

  void _performSearch() {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) return;

    final token = Provider.of<TokenProvider>(context, listen: false).getToken().toString();

    setState(() {
      _searchFuture = TaskService().searchTask(token: token, keyword: keyword);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Tasks"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Enter keyword...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _performSearch,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (_) => _performSearch(),
            ),
          ),
          Expanded(
            child: _searchFuture == null
                ? const Center(child: Text("Type a keyword to start searching"))
                : FutureBuilder<TaskListingModel>(
              future: _searchFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                final tasks = snapshot.data?.tasks;

                if (tasks == null || tasks.isEmpty) {
                  return const Center(child: Text("No tasks match your search"));
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      leading: Icon(
                        task.complete == true
                            ? Icons.check_circle
                            : Icons.radio_button_unchecked,
                        color: task.complete == true ? Colors.green : Colors.grey,
                      ),
                      title: Text(task.description ?? "No description"),
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