import 'package:flutter/material.dart';
import 'package:task_category_product/models/category_model.dart';
import 'package:task_category_product/models/product_model.dart';
import 'package:task_category_product/services/category_service.dart';
import 'package:task_category_product/services/product_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategoryId;

  final ProductServices productServices = ProductServices();
  final CategoryServices categoryServices = CategoryServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Navigate to Create Product
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Product"),
          ),
          const SizedBox(width: 15),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // CAROUSEL
              // =========================

              SizedBox(
                height: 230,
                width: double.infinity,
                child: PageView(
                  children: [
                    _carouselItem("Product Image 1"),
                    _carouselItem("Product Image 2"),
                    _carouselItem("Product Image 3"),
                    _carouselItem("Product Image 4"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // CATEGORY TITLE
              // =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Categories",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Navigate to Create Category
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add"),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // =========================
              // CATEGORIES
              // =========================
              SizedBox(
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
                        // ALL BUTTON
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: _categoryButton(
                            title: "All",
                            isSelected: selectedCategoryId == null,
                            onTap: () {
                              setState(() {
                                selectedCategoryId = null;
                              });
                            },
                          ),
                        ),

                        // FIRESTORE CATEGORIES
                        ...categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _categoryButton(
                              title: category.categoryName ?? "Unknown",
                              isSelected:
                                  selectedCategoryId == category.categoryId,
                              onTap: () {
                                setState(() {
                                  selectedCategoryId = category.categoryId;
                                });
                              },
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // PRODUCTS TITLE
              // =========================
              const Text(
                "Products",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              // =========================
              // PRODUCTS GRID
              // =========================
              StreamBuilder<List<ProductModel>>(
                stream: productServices.getAllProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  }

                  final products = snapshot.data ?? [];

                  // FILTER PRODUCTS
                  final filteredProducts = selectedCategoryId == null
                      ? products
                      : products
                            .where(
                              (product) =>
                                  product.categoryId == selectedCategoryId,
                            )
                            .toList();

                  if (filteredProducts.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          "No products found",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return _productCard(product);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // CAROUSEL ITEM
  // =========================================================

  Widget _carouselItem(String text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade200,
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // =========================================================
  // CATEGORY BUTTON
  // =========================================================

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

  // =========================================================
  // PRODUCT CARD
  // =========================================================

  Widget _productCard(ProductModel product) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
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
                      onPressed: () {
                        // Save functionality will be added
                        // after Firebase Authentication.
                      },
                      icon: const Icon(Icons.star_border),
                    ),

                    // EDIT
                    IconButton(
                      onPressed: () {
                        // TODO: Navigate to Update Product
                      },
                      icon: const Icon(Icons.edit),
                    ),

                    // DELETE
                    IconButton(
                      onPressed: () {
                        // TODO: Delete Product
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
