import 'package:flutter/material.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;
  bool _isLoading = false;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userId => _userId;

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    _userId = "unique_user_id";
    _isLoading = false;
    notifyListeners();

    return _isAuthenticated;
  }

  void signOut() {
    _isAuthenticated = false;
    _userId = null;
    notifyListeners();
  }
}
