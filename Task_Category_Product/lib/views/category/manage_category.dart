import 'package:flutter/material.dart';
import 'package:task_category_product/models/category_model.dart';
import 'package:task_category_product/services/category_service.dart';
import 'package:task_category_product/views/category/create_category.dart';

class ManageCategories extends StatefulWidget {
  const ManageCategories({super.key});

  @override
  State<ManageCategories> createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  final CategoryServices categoryServices = CategoryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Categories"),
        actions: [
          IconButton(
            tooltip: "Add Category",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateCategory()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: StreamBuilder<List<CategoryModel>>(
        stream: categoryServices.getAllCategories(),
        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ERROR
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final categories = snapshot.data ?? [];

          // EMPTY
          if (categories.isEmpty) {
            return const Center(
              child: Text(
                "No categories found",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // CATEGORIES
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      category.categoryName != null &&
                              category.categoryName!.isNotEmpty
                          ? category.categoryName![0].toUpperCase()
                          : "?",
                    ),
                  ),

                  title: Text(
                    category.categoryName ?? "No name",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // EDIT
                      IconButton(
                        tooltip: "Edit",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateCategory(category: category),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),

                      // DELETE
                      IconButton(
                        tooltip: "Delete",
                        onPressed: () {
                          if (category.categoryId != null) {
                            _deleteCategory(context, category.categoryId!);
                          }
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _deleteCategory(BuildContext context, String categoryId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Category"),
          content: const Text("Are you sure you want to delete this category?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      await categoryServices.deleteCategory(categoryId);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category deleted successfully")),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
