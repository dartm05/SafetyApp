import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<Map<String, String>> _messages = [];
  List<Map<String, String>> get messages => _messages;

  void addMessage(String message) {
    _messages.add({'message': message, 'isUser': 'true'});
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      _messages
          .add({'message': 'Hola, ¿en qué puedo ayudarte?', 'isUser': 'false'});
      notifyListeners();
    });
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}
