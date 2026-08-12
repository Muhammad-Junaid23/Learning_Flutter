import 'dart:convert';
import 'package:backend_api/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserService {
  String baseURL = "https://todo-nu-plum-19.vercel.app";

  /// Get Profile
  Future<UserModel> getProfile({
    required String token,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$baseURL/users/profile"),
        headers: {"Authorization": token},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return userModelFromJson(response.body);
      } else {
        throw Exception("Failed to fetch profile");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Update Profile
  Future<bool> updateProfile({
    required String token,
    required String name,
  }) async {
    try {
      http.Response response = await http.put(
        Uri.parse("$baseURL/users/profile"),
        headers: {
          "Authorization": token,
          "Content-Type": "application/json",
        },
        body: jsonEncode({"name": name}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Failed to update profile");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}