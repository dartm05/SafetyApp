import 'package:flutter/material.dart';

import '../../data/models/modal_model.dart';

class ModalProvider extends ChangeNotifier {
  bool? _isModalVisible = false;
  Modal? _modal;

  bool? get isModalVisible => _isModalVisible;
  Modal? get modal => _modal;

  void showModal({required Modal modal}) {
    _isModalVisible = true;
    notifyListeners();
  }

  void hideModal() {
    _isModalVisible = false;
    _modal = null;
    notifyListeners();
  }
}
