import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  final String? docId;
  final String? cityName;
  final int? population;
  final bool? visited;
  final int? createdAt;

  CityModel({
    this.docId,
    this.cityName,
    this.population,
    this.visited,
    this.createdAt,
});

  factory CityModel.fromJson(Map<String,dynamic> json) => CityModel(
    docId: json["docId"],
    cityName: json["cityName"],
    population: json["population"],
    visited: json["visited"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "docId" : docId,
    "cityName": cityName,
    "population":population,
    "visited":visited,
    "createdAt":createdAt,
  };


}