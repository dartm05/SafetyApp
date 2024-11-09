import 'package:safety_app/src/core/providers/auth_provider.dart';
import 'package:safety_app/src/features/chat/services/chat_service.dart';

import '../../../data/models/message.dart';

class ChatUsecases {
  final ChatService chatService;
  final AuthenticationProvider authenticationProvider;

  ChatUsecases(
      {required this.chatService, required this.authenticationProvider});

  Future<void> sendMessage(String message) async {
    await chatService.sendMessage(authenticationProvider.userId!, message);
  }

  Future<List<Message>> getMessages(String lastMessageId) async {
    return await chatService.getMessages(
        authenticationProvider.userId!, lastMessageId);
  }
}
