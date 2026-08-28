import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) =>
    json.encode(data.toJson(data.docId!));

class ProductModel {
  final String? docId;
  final String? categoryId;
  final String? productName;
  final double? price;
  final String? description;
  final String? image;
  final List<dynamic>? saved;
  final int? createdAt;

  ProductModel({
    this.docId,
    this.categoryId,
    this.productName,
    this.price,
    this.description,
    this.image,
    this.saved,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    docId: json["docId"],
    categoryId: json["categoryId"],
    productName: json["productName"],
    price: (json["price"] as num?)?.toDouble(),
    description: json["description"],
    image: json["image"],
    saved: json["saved"] == null
        ? []
        : List<dynamic>.from(json["saved"].map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String productId) => {
    "docId": productId,
    "categoryId": categoryId,
    "productName": productName,
    "price": price,
    "description": description,
    "image": image,
    "saved": saved == null ? [] : List<dynamic>.from(saved!.map((x) => x)),
    "createdAt": createdAt,
  };
}
