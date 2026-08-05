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
