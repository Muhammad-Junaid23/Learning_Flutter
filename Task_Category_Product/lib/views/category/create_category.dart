import 'package:flutter/material.dart';
import 'package:task_category_product/models/category_model.dart';
import 'package:task_category_product/services/category_service.dart';

class CreateCategory extends StatefulWidget {
  final CategoryModel? category;

  const CreateCategory({super.key, this.category});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final categoryNameController = TextEditingController();

  final CategoryServices categoryServices = CategoryServices();

  bool isLoading = false;

  bool get isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      categoryNameController.text = widget.category!.categoryName ?? "";
    }
  }

  // CREATE CATEGORY
  Future<void> createCategory() async {
    if (categoryNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category name is required")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final category = CategoryModel(
        categoryName: categoryNameController.text.trim(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      await categoryServices.createCategory(category);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category created successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // UPDATE CATEGORY
  Future<void> updateCategory() async {
    if (categoryNameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category name is required")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final category = CategoryModel(
        categoryId: widget.category!.categoryId,
        categoryName: categoryNameController.text.trim(),
        createdAt: widget.category!.createdAt,
      );

      await categoryServices.updateCategory(category);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category updated successfully")),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Update Category" : "Create Category"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Category Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: categoryNameController,
              decoration: const InputDecoration(
                hintText: "e.g. Electronics",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : isEditing
                    ? updateCategory
                    : createCategory,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        isEditing ? "Update Category" : "Create Category",
                        style: const TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
