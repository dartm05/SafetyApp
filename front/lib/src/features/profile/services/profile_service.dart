import 'dart:convert';

import 'package:safety_app/src/core/providers/error_provider.dart';
import 'package:safety_app/src/core/services/http_service.dart';
import 'package:safety_app/src/data/models/profile.dart';

import '../../../core/models/modal_model.dart';

class ProfileService {
  final HttpService httpService;
  final ErrorProvider errorProvider;

  ProfileService({
    required this.httpService,
    required this.errorProvider,
  });

  Future<Profile?> getProfile(String userId) async {
    try {
      var response = await httpService.get('/$userId/profile');

      if (response.statusCode > 300) {
        throw Exception('Failed to load profile');
      }
      return Profile.fromJson(jsonDecode(response.body));
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message: 'An error occurred while getting profile. Please try again.',
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
    try {
      var response =
          await httpService.post('/$userId/profile', body: profile.toJson());

      if (response.statusCode == 200) {
        return Profile.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create profile');
      }
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message:
              'An error occurred while creating profile. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
    }
    return null;
  }

  Future<Profile?> updateProfile(String userId, Profile profile) async {
    try {
      var response =
          await httpService.put('/$userId/profile', body: profile.toJson());
      if (response.statusCode > 300) {
        throw Exception('Failed to update profile');
      }
      return Profile.fromJson(jsonDecode(response.body));
    } catch (error) {
      errorProvider.showError(
        error: Modal(
          title: 'Error',
          message:
              'An error occurred while updating profile. Please try again.',
          actionText: 'Close',
          action: () {
            errorProvider.hideError();
          },
        ),
      );
    }
    return null;
  }
}