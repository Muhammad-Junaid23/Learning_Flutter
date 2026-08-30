import 'package:flutter/material.dart';
import 'package:task_category_product/models/banner_model.dart';
import 'package:task_category_product/services/banner_service.dart';

class CreateBanner extends StatefulWidget {
  const CreateBanner({super.key});

  @override
  State<CreateBanner> createState() => _CreateBannerState();
}

class _CreateBannerState extends State<CreateBanner> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  final BannerServices bannerServices = BannerServices();

  bool isLoading = false;

  Future<void> createBanner() async {
    if (titleController.text.trim().isEmpty ||
        imageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and image URL are required")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final banner = BannerModel(
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        image: imageController.text.trim(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      await bannerServices.createBanner(banner);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Banner created successfully")),
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
    titleController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Banner")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Banner Title",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "e.g. Summer Sale",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: "e.g. Up to 50% OFF",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Image URL",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: imageController,
              keyboardType: TextInputType.url,
              decoration: const InputDecoration(
                hintText: "Paste banner image URL",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : createBanner,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Create Banner",
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
