import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/videos/models/video_model.dart';
import 'package:tiktok_v2/features/videos/repos/video_repo.dart';

class VideoTimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepo _videoRepo;
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    _videoRepo = ref.read(videoProvider);
    final result = await _videoRepo.fetchVideos();
    _list = result.docs //
        .map((doc) => VideoModel.fromJson(doc.data()))
        .toList();
    return _list;
  }
}

final videoTimelineProvider =
    AsyncNotifierProvider<VideoTimelineViewModel, List<VideoModel>>(
  () => VideoTimelineViewModel(),
);
