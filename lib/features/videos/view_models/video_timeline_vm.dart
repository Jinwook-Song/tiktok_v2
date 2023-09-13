import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/videos/models/video_model.dart';

class VideoTimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];
  @override
  FutureOr<List<VideoModel>> build() async {
    // fetch data from api
    await Future.delayed(const Duration(seconds: 3));
    // throw Exception('something went wrong');
    return _list;
  }

  void uploadVideo() async {
    // trigger loading state
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 3));
    _list = [..._list];
    state = AsyncValue.data(_list);
  }
}

final videoTimelineProvider =
    AsyncNotifierProvider<VideoTimelineViewModel, List<VideoModel>>(
  () => VideoTimelineViewModel(),
);
