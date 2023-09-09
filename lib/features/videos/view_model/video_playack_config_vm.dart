import 'package:flutter/foundation.dart';
import 'package:tiktok_v2/features/videos/models/video_playback_config_model.dart';
import 'package:tiktok_v2/features/videos/repos/video_playback_config_repo.dart';

class VideoPlaybackConfigViewModel extends ChangeNotifier {
  final VideoPlaybackConfigRepo _videoPlaybackConfigRepo;

  late final VideoPlaybackConfigModel _videoPlaybackConfigModel =
      VideoPlaybackConfigModel(
    muted: _videoPlaybackConfigRepo.isMuted,
    autoplay: _videoPlaybackConfigRepo.isAutoplay,
  );

  VideoPlaybackConfigViewModel(this._videoPlaybackConfigRepo);

  bool get isMuted => _videoPlaybackConfigModel.muted;
  bool get isAutoplay => _videoPlaybackConfigModel.autoplay;

  void setMuted(bool value) {
    _videoPlaybackConfigRepo.setMuted(value);
    _videoPlaybackConfigModel.muted = value;
    notifyListeners();
  }

  void setAutoplay(bool value) {
    _videoPlaybackConfigRepo.setAutoplay(value);
    _videoPlaybackConfigModel.autoplay = value;
    notifyListeners();
  }
}
