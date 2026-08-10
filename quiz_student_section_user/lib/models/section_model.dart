import 'dart:convert';

// SectionModel sectionModelFromJson(String str) => SectionModel.fromJson(json.decode(str));
//
// String sectionModelToJson(SectionModel data) => json.encode(data.toJson());

class SectionModel {
  final String? docId;
  final String? sectionName;
  final int? createdAt;

  SectionModel({
    this.docId,
    this.sectionName,
    this.createdAt,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) => SectionModel(
    docId: json["docId"],
    sectionName: json["sectionName"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String sectionId) => {
    "docId": sectionId,
    "sectionName": sectionName,
    "createdAt": createdAt,
  };
}