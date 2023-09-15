import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/videos/models/video_model.dart';
import 'package:tiktok_v2/features/videos/repos/video_repo.dart';

class VideoTimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideoRepo _videoRepo;
  List<VideoModel> _list = [];

  Future<List<VideoModel>> _fetchVideos({
    int? lastVideoCreatedAt,
  }) async {
    final videos = await _videoRepo.fetchVideos(
      lastVideoCreatedAt: lastVideoCreatedAt,
    );
    return videos.docs.map((doc) => VideoModel.fromJson(doc.data())).toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _videoRepo = ref.read(videoProvider);
    _list = await _fetchVideos(lastVideoCreatedAt: null);
    return _list;
  }

  Future<void> fecthNextVideos() async {
    final nextVideos = await _fetchVideos(
      lastVideoCreatedAt: _list.last.createdAt,
    );
    _list = [..._list, ...nextVideos];
    state = AsyncValue.data([..._list]);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final videos = await _fetchVideos(lastVideoCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(_list);
  }
}

final videoTimelineProvider =
    AsyncNotifierProvider<VideoTimelineViewModel, List<VideoModel>>(
  () => VideoTimelineViewModel(),
);
