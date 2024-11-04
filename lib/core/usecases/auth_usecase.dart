import 'dart:convert';

import '../models/modal.model.dart';
import '../models/user.model.dart';
import '../providers/modal.provider.dart';
import '../services/http.service.dart';
import '../providers/error_provider.dart';

class AuthUsecase {
  final HttpService httpService;
  final ErrorProvider errorProvider;
  final ModalProvider modalProvider;

  AuthUsecase(
      {required this.httpService,
      required this.errorProvider,
      required this.modalProvider});

  Future<UserModel?> signIn(String email, String password) async {
    try {
      final response = await httpService.get(
        '/users/users',
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        errorProvider.showError(
          error: Modal(
            title: 'Error',
            message: 'Invalid email or password. Please try again.',
            actionText: 'Close',
            action: () {
              errorProvider.hideError();
            },
          ),
        );
        return null;
      }
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message: 'An error occurred while signing in. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
      return null;
    }
  }

  Future<void> createUser(String email, String password, String name) async {
    try {
      final response = await httpService.post(
        '/register',
        body: {
          'email': email,
          'password': password,
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        modalProvider.showModal(
          modal: Modal(
            title: 'Success',
            message: 'User created successfully.',
            actionText: 'Close',
            action: () {
              modalProvider.hideModal();
            },
          ),
        );
      } else {
        errorProvider.showError(
          error: Modal(
            title: 'Error',
            message: 'An error occurred while creating user. Please try again.',
            actionText: 'Close',
            action: () {
              errorProvider.hideError();
            },
          ),
        );
      }
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message: 'An error occurred while creating user. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
    }
  }
}
