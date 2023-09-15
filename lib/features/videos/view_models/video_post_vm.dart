import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/features/videos/repos/video_repo.dart';
import 'package:tiktok_v2/features/videos/view_models/video_timeline_vm.dart';

// Video creator가 누구인지 미리 알기위해 인자를 받아 초기화
class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepo _videoRepo;
  late final _videoId;

  @override
  FutureOr<void> build(String arg) {
    _videoId = arg;
    _videoRepo = ref.read(videoProvider);
  }

  Future<void> toggleLikeVideo() async {
    final uid = ref.read(authProvider).user!.uid;
    final videos = ref.watch(videoTimelineProvider).value;
    final video = videos!.firstWhere((video) => video.id == _videoId);
    await _videoRepo.toggleLikeVideo(
      videoId: _videoId,
      uid: uid,
      thumbnailUrl: video.thumbnailUrl,
    );
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
