import 'dart:convert';

class UserModel {
  final String? docId;
  final String? name;
  final String? email;
  final String? address;
  final String? phone;
  final int? createdAt;

  UserModel({
    this.docId,
    this.name,
    this.email,
    this.address,
    this.phone,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    docId: json["docId"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    phone: json["phone"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "name": name,
    "email": email,
    "address": address,
    "phone": phone,
    "createdAt": createdAt,
  };
}