import 'package:flutter/material.dart';

import '../../../data/models/profile.dart';
import '../usecases/profile_usecases.dart';

class ProfileProvider extends ChangeNotifier {

  final ProfileUsecase profileUsecase;
  Profile? profile; 

  get profileData => profile;

  ProfileProvider({
    required this.profileUsecase,
  });

  Future<void> getProfile() async {
    profile = await profileUsecase.getProfile();
    notifyListeners();
  }

  Future<void> updateProfile(Profile profile) async {
    profile = await profileUsecase.updateProfile(profile) ?? profile;
    notifyListeners();
  }

  Future<void> createProfile(Profile profile) async {
    profile = await profileUsecase.createProfile(profile) ?? profile;
    notifyListeners();
  }


}