import 'package:flutter/material.dart';

import '../../../data/models/profile.dart';
import '../usecases/profile_usecases.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileUsecase profileUsecase;
  Profile? profile;
  bool isLoading = false;

  get profileData => profile;
  get isLoadingData => isLoading;

  ProfileProvider({
    required this.profileUsecase,
  });

  Future<void> getProfile() async {
    isLoading = true;
    await profileUsecase.getProfile().then((value) {
      profile = value;
      isLoading = false;
      notifyListeners();
    }).catchError((error) {
      isLoading = false;
      notifyListeners();
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
    });
  }

  Future<void> updateProfile(Profile profile) async {
    profile = await profileUsecase.updateProfile(profile) ?? profile;
    notifyListeners();
  }

  Future<bool> createProfile(Profile profile) async {
    final newProfile = await profileUsecase.createProfile(profile);
    if (newProfile != null) {
      this.profile = newProfile;
    }
    notifyListeners();
    return newProfile != null;
  }
}
