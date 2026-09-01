import 'package:flutter/material.dart';
import 'package:task_category_product/models/product_model.dart';
import 'package:task_category_product/services/product_service.dart';
import 'package:task_category_product/views/product/create_product.dart';
import 'package:task_category_product/views/product/product_details.dart';

class ManageProducts extends StatefulWidget {
  const ManageProducts({super.key});

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final ProductServices productServices = ProductServices();

  Future<void> _deleteProduct(BuildContext context, String productId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Product"),
          content: const Text("Are you sure you want to delete this product?"),
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
      await productServices.deleteProduct(productId);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product deleted successfully")),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  void _openCreateProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateProduct()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ElevatedButton.icon(
              onPressed: _openCreateProduct,
              icon: const Icon(Icons.add),
              label: const Text("Add Product"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<List<ProductModel>>(
          stream: productServices.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final products = snapshot.data ?? [];

            if (products.isEmpty) {
              return const Center(
                child: Text(
                  "No products found",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.68,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return _productCard(context, product);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _productCard(BuildContext context, ProductModel product) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: product.image != null && product.image!.isNotEmpty
                  ? Image.network(
                      product.image!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.image_not_supported, size: 50),
                        );
                      },
                    )
                  : const Center(child: Icon(Icons.image, size: 50)),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName ?? "No Name",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: "Save",
                        onPressed: () {
                          // Save functionality later
                          // after Firebase Authentication.
                        },
                        icon: const Icon(Icons.star_border, size: 20),
                      ),

                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: "Edit",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateProduct(product: product),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit, size: 20),
                      ),

                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: "Delete",
                        onPressed: () {
                          if (product.docId != null) {
                            _deleteProduct(context, product.docId!);
                          }
                        },
                        icon: const Icon(Icons.delete, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
