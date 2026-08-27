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
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json["categoryId"],
      categoryName: json["categoryName"],
      createdAt: json["createdAt"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "categoryId": categoryId,
      "categoryName": categoryName,
      "createdAt": createdAt,
    };
  }
}
