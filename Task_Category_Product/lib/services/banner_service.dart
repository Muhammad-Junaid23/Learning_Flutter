import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_category_product/models/banner_model.dart';

class BannerServices {
  final String bannerCollection = "BannerCollection";

  // CREATE BANNER
  Future<void> createBanner(BannerModel model) async {
    final DocumentReference docRef = FirebaseFirestore.instance
        .collection(bannerCollection)
        .doc();

    final String bannerId = docRef.id;

    await docRef.set(model.toJson(bannerId));
  }

  // GET ALL BANNERS
  Stream<List<BannerModel>> getAllBanners() {
    return FirebaseFirestore.instance
        .collection(bannerCollection)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => BannerModel.fromJson(doc.data()))
              .toList(),
        );
  }

  // UPDATE BANNER
  Future<void> updateBanner(BannerModel model) async {
    if (model.docId == null) return;

    await FirebaseFirestore.instance
        .collection(bannerCollection)
        .doc(model.docId)
        .update(model.toJson(model.docId!));
  }

  // DELETE BANNER
  Future<void> deleteBanner(String bannerId) async {
    await FirebaseFirestore.instance
        .collection(bannerCollection)
        .doc(bannerId)
        .delete();
  }
}
