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
  }) => ProductModel(
    productId: productId ?? this.productId,
    productName: productName ?? this.productName,
    categoryId: categoryId ?? this.categoryId,
    price: price ?? this.price,
    description: description ?? this.description,
    image: image ?? this.image,
    createdAt: createdAt ?? this.createdAt,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productId: json["productId"],
    productName: json["productName"],
    categoryId: json["categoryId"],
    price: (json["price"] as num?)?.toDouble(),
    description: json["description"],
    image: json["image"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "productName": productName,
    "categoryId": categoryId,
    "price": price,
    "description": description,
    "image": image,
    "createdAt": createdAt,
  };
}
class ProductModel {
  final String? docId;
  final String? categoryID;
  final String? productName;
  final int? stock;
  final List<dynamic>? saved;
  final int? createdAt;

  ProductModel({
    this.docId,
    this.categoryID,
    this.productName,
    this.stock,
    this.saved,
    this.createdAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    docId: json["docId"],
    categoryID: json["categoryID"],
    productName: json["productName"],
    stock: json["stock"],
    saved: json["saved"] == null ? [] : List<dynamic>.from(json["saved"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String productID) => {
    "docId": productID,
    "categoryID":categoryID,
    "productName": productName,
    "stock": stock,
    "saved": saved == null ? [] : List<dynamic>.from(saved!.map((x) => x)),
    "createdAt": createdAt,
  };
}