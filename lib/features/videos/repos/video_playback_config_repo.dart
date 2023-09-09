import 'package:shared_preferences/shared_preferences.dart';

class VideoPlaybackConfigRepo {
  static const String _muted = 'muted';
  static const String _autoplay = 'autoplay';

  final SharedPreferences _prefs;

  VideoPlaybackConfigRepo(this._prefs);

  bool get isMuted => _prefs.getBool(_muted) ?? true;
  bool get isAutoplay => _prefs.getBool(_autoplay) ?? false;

  Future<void> setMuted(bool value) async {
    await _prefs.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    await _prefs.setBool(_autoplay, value);
  }
}
