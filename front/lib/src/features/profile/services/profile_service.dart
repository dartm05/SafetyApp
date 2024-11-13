import 'dart:convert';

import 'package:safety_app/src/core/providers/error_provider.dart';
import 'package:safety_app/src/core/providers/modal_provider.dart';
import 'package:safety_app/src/core/services/http_service.dart';
import 'package:safety_app/src/data/models/profile.dart';
import 'package:safety_app/src/data/models/error.dart';
import '../../../data/models/modal_model.dart';

class ProfileService {
  final HttpService httpService;
  final ErrorProvider errorProvider;
  final ModalProvider modalProvider;

  ProfileService({
    required this.httpService,
    required this.errorProvider,
    required this.modalProvider,
  });

  Future<Profile?> getProfile(String userId) async {
    try {
      var response = await httpService.get('/$userId/profile');
      return Profile.fromJson(jsonDecode(response.body));
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Create your profile',
          message: 'Let us get to know you better to provide better services',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
      return null;
    }
  }

  Future<Profile?> createProfile(String userId, Profile profile) async {
    var response =
        await httpService.post('/$userId/profile', body: profile.toJson());

    if (response.statusCode == 404) {
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      Error error = Error(
        title: errorResponse['title'],
        message: errorResponse['message'],
        statusCode: errorResponse['statusCode'],
        status: errorResponse['status'],
      );
      errorProvider.showError(
        error: Modal(
          title: error.title,
          message: error.message,
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
      return null;
    }
    errorProvider.showError(
      error: Modal(
        title: 'Success',
        message: 'Profile created successfully',
        actionText: 'Close',
        action: () {
          errorProvider.hideError();
        },
      ),
    );

    return Profile.fromJson(jsonDecode(response.body));
  }

  Future<Profile?> updateProfile(String userId, Profile profile) async {
    var response =
        await httpService.put('/$userId/profile', body: profile.toJson());

    if (response.statusCode == 404) {
      final Map<String, dynamic> errorResponse = jsonDecode(response.body);
      Error error = Error(
        title: errorResponse['title'],
        message: errorResponse['message'],
        statusCode: errorResponse['statusCode'],
        status: errorResponse['status'],
      );
      errorProvider.showError(
        error: Modal(
          title: error.title,
          message: error.message,
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
      return null;
    }
    errorProvider.showError(
      error: Modal(
        title: 'Success',
        message: 'Profile updated successfully',
        actionText: 'Close',
        action: () {
          errorProvider.hideError();
        },
      ),
    );
    return Profile.fromJson(jsonDecode(response.body));
  }
}
