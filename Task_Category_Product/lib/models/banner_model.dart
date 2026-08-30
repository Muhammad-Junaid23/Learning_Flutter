import 'dart:convert';

BannerModel bannerModelFromJson(String str) =>
    BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) =>
    json.encode(data.toJson(data.docId!));

class BannerModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? image;
  final int? createdAt;

  BannerModel({
    this.docId,
    this.title,
    this.description,
    this.image,
    this.createdAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    docId: json["docId"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String bannerId) => {
    "docId": bannerId,
    "title": title,
    "description": description,
    "image": image,
    "createdAt": createdAt,
  };
}
