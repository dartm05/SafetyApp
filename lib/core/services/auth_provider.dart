import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;
  bool _isLoading = false;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userId => _userId;

  AuthenticationProvider() {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _isAuthenticated = _userId != null;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    _userId = "unique_user_id";
    _isLoading = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', _userId!);

    notifyListeners();

    return _isAuthenticated;
  }

  void signOut() async {
    _isAuthenticated = false;
    _userId = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
  }

  Future<void> signUp(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    _isAuthenticated = true;
    _userId = "unique_user_id";
    _isLoading = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', _userId!);

    notifyListeners();
  }
}
