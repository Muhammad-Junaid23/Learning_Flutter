import 'package:flutter/material.dart';
import 'package:task_category_product/models/category_model.dart';
import 'package:task_category_product/models/product_model.dart';
import 'package:task_category_product/services/category_service.dart';
import 'package:task_category_product/services/product_service.dart';

class CreateProduct extends StatefulWidget {
  final ProductModel? product;

  const CreateProduct({super.key, this.product});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  final ProductServices productServices = ProductServices();
  final CategoryServices categoryServices = CategoryServices();

  String? selectedCategoryId;
  bool isLoading = false;

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      productNameController.text = widget.product!.productName ?? "";
      priceController.text = widget.product!.price?.toString() ?? "";
      descriptionController.text = widget.product!.description ?? "";
      imageController.text = widget.product!.image ?? "";

      selectedCategoryId = widget.product!.categoryId;
    }
  }

  Future<void> createProduct() async {
    if (productNameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        selectedCategoryId == null ||
        imageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Product name, price, category and image URL are required",
          ),
        ),
      );
      return;
    }

    final double? price = double.tryParse(priceController.text.trim());

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid price")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final product = ProductModel(
        categoryId: selectedCategoryId,
        productName: productNameController.text.trim(),
        price: price,
        description: descriptionController.text.trim(),
        image: imageController.text.trim(),
        saved: [],
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      await productServices.createProduct(product);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product created successfully")),
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

  Future<void> updateProduct() async {
    if (productNameController.text.trim().isEmpty ||
        priceController.text.trim().isEmpty ||
        selectedCategoryId == null ||
        imageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Product name, price, category and image URL are required",
          ),
        ),
      );
      return;
    }

    final double? price = double.tryParse(priceController.text.trim());

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid price")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final product = ProductModel(
        docId: widget.product!.docId,
        categoryId: selectedCategoryId,
        productName: productNameController.text.trim(),
        price: price,
        description: descriptionController.text.trim(),
        image: imageController.text.trim(),
        saved: widget.product!.saved,
        createdAt: widget.product!.createdAt,
      );

      await productServices.updateProduct(product);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Product updated successfully")),
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
    productNameController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Update Product" : "Create Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Product Name",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: productNameController,
              decoration: const InputDecoration(
                hintText: "e.g. Nike Air Max",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Category",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            StreamBuilder<List<CategoryModel>>(
              stream: categoryServices.getAllCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                }

                final categories = snapshot.data ?? [];

                if (categories.isEmpty) {
                  return const Text(
                    "No categories available. Create a category first.",
                  );
                }

                return DropdownButtonFormField<String>(
                  initialValue: selectedCategoryId,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Select category",
                  ),
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.categoryId,
                      child: Text(category.categoryName ?? "Unknown"),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryId = value;
                    });
                  },
                );
              },
            ),

            const SizedBox(height: 20),

            const Text(
              "Price",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: "e.g. 2500",
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
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: "Enter product description",
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
                hintText: "Paste product image URL",
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
                    ? updateProduct
                    : createProduct,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        isEditing ? "Update Product" : "Create Product",
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
