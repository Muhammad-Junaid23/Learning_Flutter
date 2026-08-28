import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_category_product/models/category_model.dart';

class CategoryServices {
  final String categoryCollection = "CategoryCollection";

  /// CREATE CATEGORY
  Future<void> createCategory(CategoryModel model) async {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection(categoryCollection)
        .doc();

    final String categoryId = docRef.id;

    await docRef.set({...model.toJson(), "categoryId": categoryId});
  }

  /// UPDATE CATEGORY
  Future<void> updateCategory(CategoryModel model) async {
    if (model.categoryId == null) return;

    await FirebaseFirestore.instance
        .collection(categoryCollection)
        .doc(model.categoryId)
        .update(model.toJson());
  }

  /// DELETE CATEGORY
  Future<void> deleteCategory(String categoryId) async {
    await FirebaseFirestore.instance
        .collection(categoryCollection)
        .doc(categoryId)
        .delete();
  }

  /// GET ALL CATEGORIES
  Stream<List<CategoryModel>> getAllCategories() {
    return FirebaseFirestore.instance
        .collection(categoryCollection)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => CategoryModel.fromJson(doc.data()))
              .toList(),
        );
  }
}
