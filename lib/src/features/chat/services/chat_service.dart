import 'package:menopause_app/src/core/providers/auth_provider.dart';
import 'package:menopause_app/src/core/providers/error_provider.dart';
import 'package:menopause_app/src/core/services/http_service.dart';

import '../../../core/models/modal_model.dart';
import '../../../data/models/message.dart';

class ChatService {
  final HttpServiceProvider _httpServiceProvider;
  final ErrorProvider _errorProvider;
  final AuthenticationProvider _userProvider;

  ChatService({
    required HttpServiceProvider httpServiceProvider,
    required ErrorProvider errorProvider,
    required AuthenticationProvider userProvider,
  })  : _httpServiceProvider = httpServiceProvider,
        _errorProvider = errorProvider,
        _userProvider = userProvider;

  Future<void> sendMessage(String message) async {
    Message newMessage = Message(
      userId: _userProvider.userId!,
      message: message,
      timestamp: DateTime.now(),
      isUser: true,
    );
    try {
      await _httpServiceProvider.post(
        '/messages',
        body: {
          'message': newMessage.toMap(),
          'userId': _userProvider.userId!,
        },
      );
    } catch (error) {
      _errorProvider.showError(
        error: Modal(
          title: 'Error',
          message: 'An error occurred while sending message. Please try again.',
          actionText: 'Close',
          action: () {
            _errorProvider.hideError();
          },
        ),
      );
    }
  }

  Future<List<Message>> getMessages(String lastMessageId) async {
    try {
      final response = await _httpServiceProvider.get(
        '/messages',
        body: {
          'userId': _userProvider.userId!,
          'lastMessageId': lastMessageId,
        },
      );
       final messages = [
        {
          "id": "1",
          "userId": "1",
          "message": "Hello",
          "timestamp": "2021-10-10T10:10:10.000Z",
          "isUser": "true"
        }
      ];
      return messages.map((message) => Message.fromMap(message)).toList();
    } catch (error) {
      _errorProvider.showError(
        error: Modal(
          title: 'Error',
          message:
              'An error occurred while fetching messages. Please try again.',
          actionText: 'Close',
          action: () {
            _errorProvider.hideError();
          },
        ),
      );
      return [];
    }
  }
}
