import 'package:flutter/material.dart';
import 'package:task_category_product/models/product_model.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =====================================================
            // PRODUCT IMAGE
            // =====================================================

            Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ),
              clipBehavior: Clip.antiAlias,
              child: product.image != null && product.image!.isNotEmpty
                  ? Image.network(
                      product.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.image_not_supported, size: 70),
                        );
                      },
                    )
                  : const Center(child: Icon(Icons.image, size: 70)),
            ),

            const SizedBox(height: 25),

            // =====================================================
            // PRODUCT NAME + SAVE
            // =====================================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    product.productName ?? "No Name",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                IconButton(
                  onPressed: () {
                    // Save functionality later
                    // after Firebase Authentication
                  },
                  icon: const Icon(Icons.star_border, size: 30),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // =====================================================
            // PRICE
            // =====================================================
            Text(
              "\$${product.price?.toStringAsFixed(2) ?? "0.00"}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            // =====================================================
            // DESCRIPTION
            // =====================================================
            const Text(
              "Description",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              product.description?.isNotEmpty == true
                  ? product.description!
                  : "No description available.",
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 25),

            // =====================================================
            // CATEGORY
            // =====================================================
            const Text(
              "Category",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              product.categoryId ?? "No category",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            // =====================================================
            // ACTION BUTTON
            // =====================================================
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Future functionality
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
