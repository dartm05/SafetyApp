import 'package:safety_app/src/core/providers/auth_provider.dart';
import 'package:safety_app/src/features/chat/services/chat_service.dart';

import '../../../data/models/message.dart';

class ChatUsecases {
  final ChatService chatService;
  final AuthenticationProvider authenticationProvider;

  ChatUsecases(
      {required this.chatService, required this.authenticationProvider});

  Future<Message?> sendMessage(String message) async {
    return await chatService.sendMessage(
        authenticationProvider.userId!, message);
  }

  Future<List<Message>?> getMessages() async {
    return await chatService.getMessages(authenticationProvider.userId!);
  }

  Future<void> deleteMessages() async {
    return await chatService.deleteMessages(authenticationProvider.userId!);
  }
}
