import 'package:flutter/material.dart';

import '../models/modal.model.dart';

class ErrorProvider extends ChangeNotifier {
  Modal? _error;
  bool? _isErrorVisible;

  Modal? get error => _error;
  bool? get isErrorVisible => _isErrorVisible;

  void showError({required Modal error}) {
    _error = error;
    _isErrorVisible = true;
    notifyListeners();
  }

  void hideError() {
    _isErrorVisible = false;
    _error = null;
    notifyListeners();
  }
}
