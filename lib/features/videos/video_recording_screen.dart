import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late CameraController _cameraController;
  late FlashMode _flashMode;

  @override
  void initState() {
    super.initState();
    _initPermissions();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.max,
    );
    await _cameraController.initialize();
    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> _initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await _initCamera();
      setState(() {});
    }
  }

  Future<void> _toggleCameraDirection() async {
    _isSelfieMode = !_isSelfieMode;
    await _initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode flashMode) async {
    if (flashMode == FlashMode.torch && _isSelfieMode) return;
    await _cameraController.setFlashMode(flashMode);
    _flashMode = flashMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _hasPermission && _cameraController.value.isInitialized
          ? SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CameraPreview(
                      _cameraController,
                    ),
                  ),
                  Positioned(
                    top: Sizes.size16,
                    right: Sizes.size16,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _toggleCameraDirection,
                          icon: const Icon(
                            Icons.cameraswitch,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _setFlashMode(FlashMode.off),
                          icon: Icon(
                            Icons.flash_off,
                            color: _flashMode == FlashMode.off
                                ? Colors.amber
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _setFlashMode(FlashMode.always),
                          icon: Icon(
                            Icons.flash_on,
                            color: _flashMode == FlashMode.always
                                ? Colors.amber
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _setFlashMode(FlashMode.auto),
                          icon: Icon(
                            Icons.flash_auto,
                            color: _flashMode == FlashMode.auto
                                ? Colors.amber
                                : Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () => _setFlashMode(FlashMode.torch),
                          icon: Icon(
                            Icons.flashlight_on,
                            color: _flashMode == FlashMode.torch
                                ? Colors.amber
                                : Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
