import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/videos/view_models/video_timeline_vm.dart';
import 'package:tiktok_v2/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({
    super.key,
    required this.isActivated,
  });

  final bool isActivated;

  @override
  ConsumerState<VideoTimelineScreen> createState() =>
      VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _videoCount = 0;
  final PageController _pageController = PageController();
  final _scrollDuration = const Duration(milliseconds: 50);
  final _scrollCurve = Curves.easeOut;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _videoCount - 1) {
      ref.read(videoTimelineProvider.notifier).fecthNextVideos();
    }
  }

  void _onVideoFinished() {
    return;
    // 다음 영상 자동 재생
    //_pageController.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  Future<void> _onRefresh() async {
    ref.read(videoTimelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(videoTimelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load videos:\n$error',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          data: (videos) {
            _videoCount = videos.length;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              edgeOffset: 20,
              displacement: 40,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    isActivated: widget.isActivated,
                    onVideoFinished: _onVideoFinished,
                    videoIndex: index,
                    videoData: videoData,
                  );
                },
              ),
            );
          },
        );
  }
}
