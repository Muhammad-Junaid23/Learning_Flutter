import 'package:flutter/material.dart';

import 'package:task_category_product/models/category_model.dart';
import 'package:task_category_product/models/product_model.dart';

import 'package:task_category_product/services/category_service.dart';
import 'package:task_category_product/services/product_service.dart';

import 'package:task_category_product/views/product/manage_products.dart';
import 'package:task_category_product/views/product/product_details.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key});

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  String? selectedCategoryId;

  final CategoryServices categoryServices = CategoryServices();
  final ProductServices productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =========================================================
        // CATEGORIES TITLE
        // =========================================================

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Categories",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // =========================================================
        // CATEGORIES
        // =========================================================
        CategoryList(
          selectedCategoryId: selectedCategoryId,
          categoryServices: categoryServices,
          onCategorySelected: (categoryId) {
            setState(() {
              selectedCategoryId = categoryId;
            });
          },
        ),

        const SizedBox(height: 25),

        // =========================================================
        // PRODUCTS TITLE
        // =========================================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Products",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ManageProducts(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text("Manage"),
            ),
          ],
        ),

        const SizedBox(height: 15),

        // =========================================================
        // PRODUCTS
        // =========================================================
        ProductGrid(
          selectedCategoryId: selectedCategoryId,
          productServices: productServices,
        ),
      ],
    );
  }
}

// =============================================================
// CATEGORY LIST
// =============================================================

class CategoryList extends StatelessWidget {
  final String? selectedCategoryId;
  final CategoryServices categoryServices;
  final Function(String?) onCategorySelected;

  const CategoryList({
    super.key,
    required this.selectedCategoryId,
    required this.categoryServices,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: StreamBuilder<List<CategoryModel>>(
        stream: categoryServices.getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          final categories = snapshot.data ?? [];

          return ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // =================================================
              // ALL
              // =================================================

              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _categoryButton(
                  title: "All",
                  isSelected: selectedCategoryId == null,
                  onTap: () {
                    onCategorySelected(null);
                  },
                ),
              ),

              // =================================================
              // FIRESTORE CATEGORIES
              // =================================================
              ...categories.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: _categoryButton(
                    title: category.categoryName ?? "Unknown",
                    isSelected: selectedCategoryId == category.categoryId,
                    onTap: () {
                      onCategorySelected(category.categoryId);
                    },
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _categoryButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? Colors.deepPurple : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(title),
    );
  }
}

// =============================================================
// PRODUCT GRID
// =============================================================

class ProductGrid extends StatelessWidget {
  final String? selectedCategoryId;
  final ProductServices productServices;

  const ProductGrid({
    super.key,
    required this.selectedCategoryId,
    required this.productServices,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: productServices.getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        final products = snapshot.data ?? [];

        // =======================================================
        // FILTER PRODUCTS
        // =======================================================

        final filteredProducts = selectedCategoryId == null
            ? products
            : products
                  .where((product) => product.categoryId == selectedCategoryId)
                  .toList();

        if (filteredProducts.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: Text("No products found", style: TextStyle(fontSize: 16)),
            ),
          );
        }

        // =======================================================
        // GRID
        // =======================================================

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 4 : 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.68,
          ),
          itemCount: filteredProducts.length,
          itemBuilder: (context, index) {
            final product = filteredProducts[index];

            return _productCard(context, product);
          },
        );
      },
    );
  }

  // =============================================================
  // PRODUCT CARD
  // =============================================================

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
            // IMAGE
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

            // PRODUCT INFORMATION
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
                      // SAVE
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: "Save",
                        onPressed: () {
                          // Save functionality later
                        },
                        icon: const Icon(Icons.star_border, size: 20),
                      ),

                      // EDIT
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: "Edit",
                        onPressed: () {
                          // Your existing edit code
                        },
                        icon: const Icon(Icons.edit, size: 20),
                      ),

                      // DELETE
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: "Delete",
                        onPressed: () {
                          // Your existing delete code
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
