import 'package:flutter/material.dart';
import 'package:safety_app/src/data/models/message.dart';
import 'package:safety_app/src/features/chat/usecases/chat_usecases.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatProvider with ChangeNotifier {
  final ChatUsecases chatUsecases;
  List<Message> _messages = [];
  String? _lastMessageId;

  ChatProvider({required this.chatUsecases}) {
    _initializeMessages();
  }
  List<Message> get messages => _messages;

  Future<void> _initializeMessages() async {
    final prefs = await SharedPreferences.getInstance();
    _lastMessageId = prefs.getString('lastMessageId');

    _messages = await fetchMessagesAfter(_lastMessageId);

    if (_messages.isNotEmpty) {
      _lastMessageId = _messages.last.id;
      prefs.setString('lastMessageId', _lastMessageId!);
    }
    notifyListeners();
  }

  Future<void> fetchNewMessages() async {
    final newMessages = await fetchMessagesAfter(_lastMessageId);
    _messages.addAll(newMessages);
    _lastMessageId = _messages.last.id;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastMessageId', _lastMessageId!);
    notifyListeners();
  }

  Future<List<Message>> fetchMessagesAfter(String? lastMessageId) async {
    return await chatUsecases.getMessages(lastMessageId ?? '');
  }

  Future<void> sendMessage(String message) async {
    await chatUsecases.sendMessage(message);
    await fetchNewMessages();
  }
}
