import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/user/models/user_profile_model.dart';
import 'package:tiktok_v2/features/user/repos/user_repo.dart';

class UserProfileViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepo _userRepo;
  @override
  FutureOr<UserProfileModel> build() {
    _userRepo = ref.read(userProvider);
    return UserProfileModel.empty();
  }

  Future<void> createUserProfile(UserCredential userCredential) async {
    state = const AsyncValue.loading();
    final user = userCredential.user!;
    final profile = UserProfileModel(
      uid: user.uid,
      email: user.email!,
      name: user.displayName ?? "Anonymous",
      bio: 'undefined',
      link: 'undefined',
    );
    await _userRepo.createUserProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final userProfileProvider =
    AsyncNotifierProvider<UserProfileViewModel, UserProfileModel>(
  () => UserProfileViewModel(),
);
