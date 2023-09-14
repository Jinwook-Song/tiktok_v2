import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/features/user/view_models/user_profile_vm.dart';
import 'package:tiktok_v2/features/videos/models/video_model.dart';
import 'package:tiktok_v2/features/videos/repos/video_repo.dart';
import 'package:tiktok_v2/utils.dart';

class VideoUploadViewModel extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;
  late final VideoRepo _videoRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authProvider);
    _videoRepo = ref.read(videoProvider);
  }

  Future<void> uploadVideo({
    required BuildContext context,
    required File video,
  }) async {
    final uid = _authRepo.user!.uid;
    final userProfile = ref.read(userProfileProvider).value;
    if (userProfile == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final task = await _videoRepo.uploadVideo(
          video: video,
          uid: uid,
        );
        if (task.metadata != null) {
          final video = VideoModel(
            title: 'From flutter',
            description: 'Hello',
            fileUrl: await task.ref.getDownloadURL(),
            thumbnailUrl: '',
            creatorUid: uid,
            creator: userProfile.name,
            likes: 0,
            comments: 0,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          );
          await _videoRepo.createVideoDocument(video);
        }
      },
    );
    if (state.hasError) {
      showFirebaseErrorSnackBar(context, state.error);
    } else {
      context.pop(); // video recording
      context.pop(); // main navigation
    }
  }
}

final videoUploadProvider = AsyncNotifierProvider<VideoUploadViewModel, void>(
  () => VideoUploadViewModel(),
);
