import 'dart:convert';
import 'package:backend_api/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseURL = "https://todo-nu-plum-19.vercel.app";

  /// Register User
  Future<RegisterModel> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$baseURL/users/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
        }),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Server timeout. Please try again.');
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return registerModelFromJson(response.body);
      } else {
        throw Exception("Registration failed");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Login User
  Future<LoginModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$baseURL/users/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return loginModelFromJson(response.body);
      } else {
        throw Exception("Login failed");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Logout User
  Future<LogoutModel> logoutUser({
    required String token,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$baseURL/users/logout"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return logoutModelFromJson(response.body);
      } else {
        throw Exception("Logout failed");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}