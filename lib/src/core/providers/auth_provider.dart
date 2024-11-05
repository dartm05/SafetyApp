import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
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

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    /*   final user = await authUseCase.signIn(email, password);
    _isLoading = false; */
    final user = UserModel(id: '1', name: '', email: email, password: password);
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

  Future<void> signUp(String email, String password, String name) async {
    _isLoading = true;
    notifyListeners();
    /* await authUseCase.createUser(email, password, name); */
    _isLoading = false;
    notifyListeners();
  }
}
