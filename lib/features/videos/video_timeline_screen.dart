import 'package:flutter/material.dart';
import 'package:tiktok_v2/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  final _scrollDuration = const Duration(milliseconds: 50);
  final _scrollCurve = Curves.easeOut;
  int _itemCount = 4;
  final List<Color> _colors = [
    Colors.amber,
    Colors.pink,
    Colors.blue,
    Colors.green,
  ];

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
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      _colors.addAll([
        Colors.amber,
        Colors.pink,
        Colors.blue,
        Colors.green,
      ]);
      setState(() {});
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(duration: _scrollDuration, curve: _scrollCurve);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: _onPageChanged,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        return VideoPost(
          onVideoFinished: _onVideoFinished,
        );
      },
    );
  }
}
