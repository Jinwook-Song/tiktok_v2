import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;
  const VideoPreviewScreen({
    super.key,
    required this.video,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController =
      VideoPlayerController.file(File(widget.video.path));

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _initVideo() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
