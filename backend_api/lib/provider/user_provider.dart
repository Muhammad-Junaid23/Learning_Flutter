import 'package:flutter/material.dart';
import 'package:backend_api/models/user_model.dart';
import 'package:backend_api/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _userModel;
  bool _isLoading = false;

  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;

  void setUser(UserModel model) {
    _userModel = model;
    notifyListeners();
  }

  // Fetch user profile from API
  Future<void> fetchProfile(String token) async {
    _isLoading = true;
    notifyListeners();

    try {
      final model = await _userService.getProfile(token: token);
      _userModel = model;
    } catch (e) {
      debugPrint("Error fetching profile: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user name and refresh profile
  Future<bool> updateProfile({required String token, required String name}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final success = await _userService.updateProfile(token: token, name: name);
      if (success) {
        await fetchProfile(token); // Refresh local state
        return true;
      }
      return false;
    } catch (e) {
      debugPrint("Error updating profile: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}