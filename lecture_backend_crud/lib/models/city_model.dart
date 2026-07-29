import 'dart:convert';

// CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));
//
// String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  final String? docId;
  final String? cityName;
  final int? population;
  final bool? visited;
  final List<dynamic>? saved;
  final int? createdAt;

  CityModel({
    this.docId,
    this.cityName,
    this.population,
    this.visited,
    this.saved,
    this.createdAt,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    docId: json["docId"],
    cityName: json["cityName"],
    population: json["population"],
    visited: json["visited"],
    saved: json["saved"] == null ? [] : List<dynamic>.from(json["saved"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String cityID) => {
    "docId": cityID,
    "cityName": cityName,
    "population": population,
    "visited": visited,
    "saved": saved == null ? [] : List<dynamic>.from(saved!.map((x) => x)),
    "createdAt": createdAt,
  };
}