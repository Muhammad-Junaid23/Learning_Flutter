import 'dart:convert';

class CountryModel{
  final String? docId;
  final String? countryName;
  final int? createdAt;

  CountryModel({
    this.docId,
    this.countryName,
    this.createdAt,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    docId: json["docId"],
    countryName: json["countryName"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String countryID) =>{
       "docId":countryID,
        "countryName": countryName,
        "createdAt":createdAt,
      };

}