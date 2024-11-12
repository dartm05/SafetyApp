import 'dart:convert';

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

  Future<List<Message>?> sendMessage(String userId, String message) async {
    Message newMessage = Message(
      userId: userId,
      message: message,
      isUser: true,
    );
    try {
      var response = await _httpService.post(
        '/$userId/messages',
        body: newMessage.toMap(),
      );
      if (response.statusCode > 300) {
        throw Exception('Error sending message');
      }
      return List<Map<String, dynamic>>.from(jsonDecode(response.body))
          .map((message) => Message.fromMap(message))
          .toList();
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

  Future<List<Message>?> getMessages(String userId) async {
    try {
      final response = await _httpService.get(
        '/$userId/messages',
      );
      if (response.statusCode == 500) {
        throw Exception('Error fetching messages');
      }
      var messages = List<Map<String, dynamic>>.from(jsonDecode(response.body));
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

  Future<void> deleteMessages(String userId) async {
    try {
      await _httpService.delete(
        '/$userId/messages',
      );
    } catch (error) {
      _errorProvider.showError(
        error: Modal(
          title: 'Error',
          message:
              'An error occurred while deleting messages. Please try again.',
          actionText: 'Close',
          action: () {
            _errorProvider.hideError();
          },
        ),
      );
    }
  }
}
