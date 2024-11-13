import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../usecases/auth_usecase.dart';

class AuthenticationProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  String? _userId;
  bool _isLoading = false;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userId => _userId;

  final AuthUsecase authUseCase;

  AuthenticationProvider({required this.authUseCase}) {
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _isAuthenticated = _userId != null;
    notifyListeners();
  }

  Future<bool> signIn(String email) async {
    _isLoading = true;
    notifyListeners();
    final user = await authUseCase.signIn(email);
    _isLoading = false;
    if (user != null) {
      _isAuthenticated = true;
      _userId = user.id;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _userId!);
      notifyListeners();
      return true;
    }

    return false;
  }

  void signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    _isAuthenticated = false;
    _userId = null;
    notifyListeners();
  }

  Future<bool> signUp(String email, String name) async {
    _isLoading = true;
    notifyListeners();
    final user = await authUseCase.createUser(email, name);
    if (user != null) {
      _isAuthenticated = true;
      _userId = user.id;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _userId!);
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }
}
