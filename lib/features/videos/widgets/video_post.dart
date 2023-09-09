import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/common/widgets/video_config/video_config.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/videos/widgets/video_button.dart';
import 'package:tiktok_v2/features/videos/widgets/video_comments.dart';
import 'package:tiktok_v2/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoIndex,
    required this.isActivated,
  });

  final void Function() onVideoFinished;
  final int videoIndex;
  final bool isActivated;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset(
    'assets/videos/yeonjae_0${(widget.videoIndex % 6) + 1}.MP4',
  );

  late AnimationController _animationController;

  bool _isPaused = false;
  bool _isMuted = false;
  final _animationDuration = const Duration(milliseconds: 150);

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      value: 1.5, // default
      lowerBound: 1.0,
      upperBound: 1.5,
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    // 웹에서는 음성이 있는 영상의 최초 자동 재생을 허용하지 않는다
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
      _isMuted = true;
    }
    setState(() {});

    _videoPlayerController.addListener(_onVideoChanged);
  }

  void _onVideoChanged() {
    if (!_videoPlayerController.value.isInitialized) return;

    if (_videoPlayerController.value.duration ==
        _videoPlayerController.value.position) {
      widget.onVideoFinished();
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return; // controller가 dispose된 상태에서 동작하지 않도록
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      _videoPlayerController.play();
    }

    if (_videoPlayerController.value.isPlaying && !widget.isActivated) {
      _toggleVideoPlaying();
    }
  }

  void _toggleVideoPlaying() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
      _isPaused = true;
    } else {
      _videoPlayerController.play();
      _animationController.forward();
      _isPaused = false;
    }

    setState(() {});
  }

  void _toggleMute() {
    if (_isMuted) {
      _isMuted = false;
      _videoPlayerController.setVolume(1);
    } else {
      _isMuted = true;
      _videoPlayerController.setVolume(0);
    }
    setState(() {});
  }

  void _onCommentTap(BuildContext context) async {
    if (!_isPaused) _toggleVideoPlaying();
    // modal이 닫히면 resolve 된다
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => const VideoComments(),
    );
    _toggleVideoPlaying();
  }

  @override
  Widget build(BuildContext context) {
    final videoMute = VideoConfig.of(context).videoMute;

    return VisibilityDetector(
      key: Key('${widget.videoIndex}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleVideoPlaying,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const Icon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '@JW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v8,
                Text(
                  'yeonjae_${widget.videoIndex}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size12,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                videoMute
                    ? FontAwesomeIcons.volumeXmark
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 16,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: Sizes.size20,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/78011042?v=4',
                  ),
                  child: Text('JW'),
                ),
                Gaps.v20,
                IconButton(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _toggleMute,
                  icon: _isMuted
                      ? const Icon(
                          FontAwesomeIcons.volumeXmark,
                          color: Colors.white,
                        )
                      : const Icon(
                          FontAwesomeIcons.volumeHigh,
                          color: Colors.white,
                        ),
                ),
                Gaps.v20,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).videoLikeCounts(9999),
                ),
                Gaps.v20,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).videoCommentCounts(1231231),
                  ),
                ),
                Gaps.v20,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: 'Share',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
