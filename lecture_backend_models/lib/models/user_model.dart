import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? userId;
  final String? name;
  final String? email;
  final int? age;
  final String? createdAt;

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.age,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["userId"],
    name: json["name"],
    email: json["email"],
    age: json["age"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "name": name,
    "email": email,
    "age": age,
    "createdAt": createdAt,
  };
}
