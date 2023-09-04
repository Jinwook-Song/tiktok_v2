import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:gallery_saver/gallery_saver.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;
  final bool fromGallery;
  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.fromGallery,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  bool _saved = false;
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

  Future<void> _saveToGallery() async {
    if (_saved) return;

    await GallerySaver.saveVideo(
      widget.video.path,
      albumName: 'TikTok',
    );

    _saved = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        actions: [
          if (!widget.fromGallery)
            IconButton(
              onPressed: _saveToGallery,
              icon: Icon(
                _saved
                    ? FontAwesomeIcons.fileCircleCheck
                    : FontAwesomeIcons.download,
              ),
            )
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
