import 'package:safety_app/src/core/providers/error_provider.dart';
import 'package:safety_app/src/core/services/http_service.dart';

import '../../../core/models/modal_model.dart';
import '../../../data/models/message.dart';

class ChatService {
  final HttpService _httpService;
  final ErrorProvider _errorProvider;

  ChatService({
    required HttpService httpService,
    required ErrorProvider errorProvider,
  })  : _httpService = httpService,
        _errorProvider = errorProvider;

  Future<void> sendMessage(String userId, String message) async {
    Message newMessage = Message(
      userId: userId,
      message: message,
      timestamp: DateTime.now(),
      isUser: true,
    );
    try {
      var response = await _httpService.post(
        '/messages',
        body: {
          'message': newMessage.toMap(),
          'userId': userId,
        },
      );
      if (response.statusCode > 300) {
        throw Exception('Error sending message');
      }
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

  Future<List<Message>> getMessages(String userId, String lastMessageId) async {
    try {
      final response = await _httpService.get(
        '/messages',
        body: {
          'userId': userId,
          'lastMessageId': lastMessageId,
        },
      );
      if (response.statusCode > 300) {
        throw Exception('Error fetching messages');
      }
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
