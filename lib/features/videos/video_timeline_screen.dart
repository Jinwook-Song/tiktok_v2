import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final List<Color> _colors = [
    Colors.amber,
    Colors.pink,
    Colors.blue,
    Colors.green,
  ];

  void _onPageChanged(int page) {
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

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: _onPageChanged,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        return Container(
          color: _colors[index],
          child: Center(
            child: Text(
              '$index',
              style: const TextStyle(
                fontSize: Sizes.size40,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
