import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:backend_api/provider/task_provider.dart';
import 'package:backend_api/provider/token_provider.dart';

class SearchTask extends StatefulWidget {
  const SearchTask({super.key});

  @override
  State<SearchTask> createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTask> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch(String token) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      Provider.of<TaskProvider>(context, listen: false)
          .searchTasks(token: token, keyword: query);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<TokenProvider>(context).getToken().toString();

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
                hintText: "Search keyword...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => _onSearch(token),
                ),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onSubmitted: (_) => _onSearch(token),
            ),
          ),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                if (taskProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (taskProvider.searchResults.isEmpty) {
                  return const Center(child: Text("No tasks found matching query"));
                }

                return ListView.builder(
                  itemCount: taskProvider.searchResults.length,
                  itemBuilder: (context, index) {
                    final task = taskProvider.searchResults[index];
                    return ListTile(
                      leading: Icon(
                        task.complete == true ? Icons.check_circle : Icons.radio_button_unchecked,
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