import 'package:flutter/material.dart';
import 'package:menopause_app/src/data/models/message.dart';
import 'package:menopause_app/src/features/chat/services/chat_service.dart';

class ChatProvider with ChangeNotifier {
  final ChatService chatService;
  List<Message> _messages = [];
  String? _lastMessageId;

  ChatProvider({required this.chatService});
  List<Message> get messages => _messages;

  Future<void> fetchNewMessages() async {
    final newMessages = await fetchMessagesAfter(_lastMessageId);

    if (newMessages.isNotEmpty) {
      _messages.addAll(newMessages);
      _lastMessageId = newMessages.last.id;
      notifyListeners();
    }
  }

  Future<List<Message>> fetchMessagesAfter(String? lastMessageId) async {
    return await chatService.getMessages(lastMessageId ?? '');
  }

  Future<void> sendMessage(String message) async {
    await chatService.sendMessage(message);
    await fetchNewMessages();
  }
}
