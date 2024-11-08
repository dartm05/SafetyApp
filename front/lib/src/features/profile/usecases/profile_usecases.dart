import 'package:safety_app/src/core/providers/auth_provider.dart';
import 'package:safety_app/src/data/models/profile.dart';

import '../services/profile_service.dart';

class ProfileUsecase {
  final ProfileService profileService;
  final AuthenticationProvider authenticationProvider;

  ProfileUsecase({
    required this.profileService,
    required this.authenticationProvider,
  });

  Future<Profile?> getProfile() async {
    return await profileService.getProfile(authenticationProvider.userId!);
  }

  Future<Profile?> updateProfile(Profile profile) async {
    return await profileService.updateProfile(
        authenticationProvider.userId!, profile);
  }

  Future<Profile?> createProfile(Profile profile) async {
    return await profileService.createProfile(
        authenticationProvider.userId!, profile);
  }
}
