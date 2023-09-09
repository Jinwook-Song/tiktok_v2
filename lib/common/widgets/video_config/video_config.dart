import 'package:flutter/material.dart';

class VideoConfigData extends InheritedWidget {
  final bool videoMute;
  final VoidCallback toggleVideoMute;

  const VideoConfigData({
    super.key,
    required super.child,
    required this.videoMute,
    required this.toggleVideoMute,
  });

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // rebuild or not
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  final Widget child;
  const VideoConfig({super.key, required this.child});

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool _videoMute = false;

  void _toggleVideoMute() {
    setState(() {
      _videoMute = !_videoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      videoMute: _videoMute,
      toggleVideoMute: _toggleVideoMute,
      child: widget.child,
    );
  }
}
