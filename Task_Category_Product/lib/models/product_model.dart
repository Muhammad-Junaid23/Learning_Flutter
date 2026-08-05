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