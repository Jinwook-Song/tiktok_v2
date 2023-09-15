import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/features/videos/models/video_model.dart';
import 'package:tiktok_v2/features/videos/repos/video_repo.dart';
import 'package:tiktok_v2/features/videos/view_models/video_timeline_vm.dart';

// Video creator가 누구인지 미리 알기위해 인자를 받아 초기화
class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideoRepo _videoRepo;
  late final String _videoId;

  VideoModel get _video {
    final videos = ref.watch(videoTimelineProvider).value;
    return videos!.firstWhere((video) => video.id == _videoId);
  }

  Future<bool> get isLiked async => await _videoRepo.isLiked(
        videoId: _videoId,
        uid: ref.read(authProvider).user!.uid,
      );

  Future<int> get likeCount async =>
      await _videoRepo.likeCount(videoId: _videoId);

  @override
  FutureOr<void> build(String arg) {
    _videoId = arg;
    _videoRepo = ref.read(videoProvider);
  }

  Future<bool> toggleLikeVideo() async {
    final uid = ref.read(authProvider).user!.uid;
    return await _videoRepo.toggleLikeVideo(
      videoId: _videoId,
      uid: uid,
      thumbnailUrl: _video.thumbnailUrl,
    );
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
