import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_category_product/models/product_model.dart';

class ProductServices {
  final String productCollection = "ProductCollection";

  /// CREATE PRODUCT
  Future<void> createProduct(ProductModel model) async {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection(productCollection)
        .doc();

    final String productId = docRef.id;

    await docRef.set(model.toJson(productId));
  }

  /// UPDATE PRODUCT
  Future<void> updateProduct(ProductModel model) async {
    if (model.docId == null) return;

    await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(model.docId)
        .update(model.toJson(model.docId!));
  }

  /// DELETE PRODUCT
  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productId)
        .delete();
  }

  /// GET ALL PRODUCTS
  Stream<List<ProductModel>> getAllProducts() {
    return FirebaseFirestore.instance
        .collection(productCollection)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ProductModel.fromJson(doc.data()))
              .toList(),
        );
  }

  /// SAVE / UNSAVE PRODUCT
  Future<void> toggleSaveProduct({
    required String productId,
    required String userId,
    required List<dynamic> savedUsers,
  }) async {
    final DocumentReference productRef = FirebaseFirestore.instance
        .collection(productCollection)
        .doc(productId);

    if (savedUsers.contains(userId)) {
      /// User already saved the product → remove user ID
      await productRef.update({
        "saved": FieldValue.arrayRemove([userId]),
      });
    } else {
      /// User has not saved the product → add user ID
      await productRef.update({
        "saved": FieldValue.arrayUnion([userId]),
      });
    }
  }
}
