import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/videos/widgets/video_button.dart';
import 'package:tiktok_v2/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoIndex,
  });

  final void Function() onVideoFinished;
  final int videoIndex;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset('assets/videos/sample.mov');

  late AnimationController _animationController;

  bool _isPaused = false;
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
        duration: _animationDuration);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
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
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      _videoPlayerController.play();
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
          const Positioned(
            bottom: 20,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '@JW',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v8,
                Text(
                  'Movie Trailer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size12,
                  ),
                ),
              ],
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
                      'https://avatars.githubusercontent.com/u/78011042?v=4'),
                  child: Text('JW'),
                ),
                Gaps.v20,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: '2.9M',
                ),
                Gaps.v20,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: '33.0K',
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
