import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
//
// String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? docId;
  final String? name;
  final String? email;
  final String? phone;
  final String? address;
  final int? createdAt;

  UserModel({
    this.docId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    docId: json["docId"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "docId": docId,
    "name": name,
    "email": email,
    "phone": phone,
    "address": address,
    "createdAt": createdAt,
  };
}