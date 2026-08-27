import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  final String? categoryId;
  final String? categoryName;
  final int? createdAt;

  CategoryModel({this.categoryId, this.categoryName, this.createdAt});

  CategoryModel copyWith({
    String? categoryId,
    String? categoryName,
    int? createdAt,
  }) => CategoryModel(
    categoryId: categoryId ?? this.categoryId,
    categoryName: categoryName ?? this.categoryName,
    createdAt: createdAt ?? this.createdAt,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "createdAt": createdAt,
  };
}
class CategoryModel {
  final String? docId;
  final String? categoryName;
  final String? createdAt;

  CategoryModel({
    this.docId,
    this.categoryName,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    docId: json["docId"],
    categoryName: json["categoryName"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "categoryName": categoryName,
    "createdAt": createdAt,
  };
}
