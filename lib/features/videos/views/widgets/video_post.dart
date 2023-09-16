import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/videos/models/video_model.dart';
import 'package:tiktok_v2/features/videos/view_models/video_playback_config_vm.dart';
import 'package:tiktok_v2/features/videos/view_models/video_post_vm.dart';
import 'package:tiktok_v2/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_v2/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_v2/generated/l10n.dart';
import 'package:tiktok_v2/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final void Function() onVideoFinished;
  final int videoIndex;
  final bool isActivated;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoIndex,
    required this.isActivated,
    required this.videoData,
  });

  @override
  ConsumerState<VideoPost> createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset(
    'assets/videos/yeonjae_0${(widget.videoIndex % 6) + 1}.MP4',
  );

  late AnimationController _animationController;

  late bool _isPaused = !ref.read(videoPlaybackConfigProvider).autoplay;
  late bool _isMuted = ref.watch(videoPlaybackConfigProvider).muted;
  bool _isLiked = false;
  late int _likeCount = widget.videoData.likes;

  final _animationDuration = const Duration(milliseconds: 150);

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      value: 1.0, // default
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
    } else {
      if (_isMuted) {
        await _videoPlayerController.setVolume(0);
      } else {
        await _videoPlayerController.setVolume(1);
      }
    }

    _videoPlayerController.addListener(_onVideoChanged);
    final isLiked = await ref
        .watch(videoPostProvider(widget.videoData.id).notifier)
        .isLiked;

    _isLiked = isLiked;
    setState(() {});
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

  void _toggleMute() async {
    _isMuted = !_isMuted;
    ref.read(videoPlaybackConfigProvider.notifier).setMuted(_isMuted);

    if (_isMuted) {
      await _videoPlayerController.setVolume(0);
    } else {
      await _videoPlayerController.setVolume(1);
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

  Future<void> _onLikeTap() async {
    final isLiked = await ref
        .read(videoPostProvider(widget.videoData.id).notifier)
        .toggleLikeVideo();

    _isLiked = isLiked;
    if (isLiked) {
      _likeCount++;
    } else {
      _likeCount--;
    }
    setState(() {});
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
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
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
                Text(
                  '@${widget.videoData.creator}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v8,
                Text(
                  formatter.format(
                    DateTime.fromMillisecondsSinceEpoch(
                      widget.videoData.createdAt,
                    ),
                  ),
                  style: const TextStyle(
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
                CircleAvatar(
                  radius: Sizes.size20,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/tiktok-jw-v2.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media',
                  ),
                  child: Text(widget.videoData.creator),
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
                GestureDetector(
                  onTap: _onLikeTap,
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    iconColor: _isLiked ? Colors.red : null,
                    text: S.of(context).videoLikeCounts(_likeCount),
                  ),
                ),
                Gaps.v20,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S
                        .of(context)
                        .videoCommentCounts(widget.videoData.comments),
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
