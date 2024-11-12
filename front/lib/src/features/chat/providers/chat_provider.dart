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

    _messages = await fetchMessagesAfter(null);

    if (_messages.isNotEmpty) {
      _lastMessageId = _messages.last.id;
      prefs.setString('lastMessageId', _lastMessageId!);
    }
    notifyListeners();
  }

  Future<void> refreshMessages() async {
    _messages = await fetchMessagesAfter(null);
    _lastMessageId = _messages.last.id;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastMessageId', _lastMessageId!);
    notifyListeners();
  }

  Future<void> fetchNewMessages() async {
    final newMessages = await fetchMessagesAfter(_lastMessageId);
    if (newMessages.isNotEmpty) {
      _messages.addAll(newMessages);
      _lastMessageId = newMessages.last.id;
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('lastMessageId', _lastMessageId!);
      notifyListeners();
    }
  }

  Future<List<Message>> fetchMessagesAfter(String? lastMessageId) async {
    return await chatUsecases.getMessages().then((messages) {
      if (lastMessageId == null) {
        return messages ?? [];
      }
      final lastMessageIndex =
          messages!.indexWhere((message) => message.id == lastMessageId);
      if (lastMessageIndex == -1) {
        return messages;
      }
      return messages.sublist(lastMessageIndex + 1);
    });
  }

  Future<void> sendMessage(String message) async {
    _messages
        .add(Message(userId: '', id: 'temp', message: message, isUser: true));
    notifyListeners();
    await chatUsecases.sendMessage(message).then((newMessages) {
      if (newMessages != null) {
        _messages.removeWhere((element) => element.id == 'temp');
        _messages.addAll(newMessages);
        _lastMessageId = newMessages.last.id;
      } else {
        _messages.removeWhere((element) => element.id == 'temp');
      }
      notifyListeners();
    });
  }

  Future<void> clearMessages() async {
    await chatUsecases.deleteMessages().then((_) {
      _messages.clear();
      _lastMessageId = null;
      notifyListeners();
    });
  }
}
