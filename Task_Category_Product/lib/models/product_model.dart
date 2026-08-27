import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  final String? productId;
  final String? productName;
  final String? categoryId;
  final double? price;
  final String? description;
  final String? image;
  final int? createdAt;

  ProductModel({
    this.productId,
    this.productName,
    this.categoryId,
    this.price,
    this.description,
    this.image,
    this.createdAt,
  });

  ProductModel copyWith({
    String? productId,
    String? productName,
    String? categoryId,
    double? price,
    String? description,
    String? image,
    int? createdAt,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json["productId"],
      productName: json["productName"],
      categoryId: json["categoryId"],
      price: (json["price"] as num?)?.toDouble(),
      description: json["description"],
      image: json["image"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "productName": productName,
      "categoryId": categoryId,
      "price": price,
      "description": description,
      "image": image,
      "createdAt": createdAt,
    };
  }
}
