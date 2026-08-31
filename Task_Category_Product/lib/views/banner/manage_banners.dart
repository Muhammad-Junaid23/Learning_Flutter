import 'package:flutter/material.dart';
import 'package:task_category_product/models/banner_model.dart';
import 'package:task_category_product/services/banner_service.dart';
import 'package:task_category_product/views/banner/create_banner.dart';

class ManageBanners extends StatefulWidget {
  const ManageBanners({super.key});

  @override
  State<ManageBanners> createState() => _ManageBannersState();
}

class _ManageBannersState extends State<ManageBanners> {
  final BannerServices bannerServices = BannerServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Banners"),
        actions: [
          IconButton(
            tooltip: "Add Banner",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateBanner()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: StreamBuilder<List<BannerModel>>(
        stream: bannerServices.getAllBanners(),
        builder: (context, snapshot) {
          // LOADING
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ERROR
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final banners = snapshot.data ?? [];

          // EMPTY
          if (banners.isEmpty) {
            return const Center(
              child: Text("No banners found", style: TextStyle(fontSize: 16)),
            );
          }

          // BANNERS
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: banners.length,
            itemBuilder: (context, index) {
              final banner = banners[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),

                  // IMAGE
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      banner.image ?? "",
                      width: 90,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 90,
                          height: 60,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image_not_supported),
                        );
                      },
                    ),
                  ),

                  // TITLE
                  title: Text(
                    banner.title ?? "No title",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  // DESCRIPTION
                  subtitle: Text(
                    banner.description ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // ACTIONS
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
                                  CreateBanner(banner: banner),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),

                      // DELETE
                      IconButton(
                        tooltip: "Delete",
                        onPressed: () {
                          if (banner.docId != null) {
                            _deleteBanner(context, banner.docId!);
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

  Future<void> _deleteBanner(BuildContext context, String bannerId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Banner"),
          content: const Text("Are you sure you want to delete this banner?"),
          actions: [
            // CANCEL
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),

            // DELETE
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
      await bannerServices.deleteBanner(bannerId);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Banner deleted successfully")),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
