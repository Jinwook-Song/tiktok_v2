import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/features/user/repos/user_repo.dart';
import 'package:tiktok_v2/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_v2/utils.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepo _userRepo;
  @override
  FutureOr<void> build() {
    _userRepo = ref.read(userProvider);
  }

  Future<void> uploadAvatar({
    required BuildContext context,
    required File file,
  }) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authProvider).user!.uid;
    state = await AsyncValue.guard(() async {
      await _userRepo.uploadAvatar(
        file,
        fileName,
      );
      await ref.read(userProfileProvider.notifier).onAvatarUploaded();
    });
    if (state.hasError) {
      showFirebaseErrorSnackBar(context, state.error);
    }
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
