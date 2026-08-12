import 'dart:convert';

// ==================== LOGIN MODEL ====================
LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));
String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final User? user;
  final String? token;
  final String? message;
  final bool? status;

  LoginModel({
    this.user,
    this.token,
    this.message,
    this.status,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
    "message": message,
    "status": status,
  };
}

// ==================== REGISTER MODEL ====================
RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));
String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final User? user;
  final String? message;
  final bool? status;

  RegisterModel({
    this.user,
    this.message,
    this.status,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "message": message,
    "status": status,
  };
}

// ==================== LOGOUT MODEL ====================
LogoutModel logoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));
String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel {
  final String? message;
  final bool? status;

  LogoutModel({
    this.message,
    this.status,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}

// ==================== USER PROFILE MODEL ====================
UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final User? user;
  final String? message;
  final bool? status;

  UserModel({
    this.user,
    this.message,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    // Handles cases where user object is nested under "user" or returned directly
    user: json["user"] != null
        ? User.fromJson(json["user"])
        : (json["_id"] != null ? User.fromJson(json) : null),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "message": message,
    "status": status,
  };
}

// ==================== SHARED USER ENTITY ====================
class User {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final int? v;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "password": password,
    "__v": v,
  };
}