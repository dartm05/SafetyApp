import 'package:menopause_app/src/features/chat/services/chat_service.dart';

import '../../../data/models/message.dart';

class ChatUsecases {
  final ChatService _chatService;

  ChatUsecases(this._chatService);

  Future<void> sendMessage(String message) async {
    await _chatService.sendMessage(message);
  }

  Future<List<Message>> getMessages(String lastMessageId) async {
    return await _chatService.getMessages(lastMessageId);
  }
}