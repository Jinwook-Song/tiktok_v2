import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/features/videos/repos/video_repo.dart';

// Video creator가 누구인지 미리 알기위해 인자를 받아 초기화
class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepo _videoRepo;
  late final _videoId;

  @override
  FutureOr<void> build(String arg) {
    _videoId = arg;
    _videoRepo = ref.read(videoProvider);
  }

  Future<void> likeVideo() async {
    final uid = ref.read(authProvider).user!.uid;
    await _videoRepo.likeVideo(videoId: _videoId, uid: uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
