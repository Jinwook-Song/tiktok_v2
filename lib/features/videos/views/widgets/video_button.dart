import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: Sizes.size32,
        ),
        Gaps.v5,
        Text(
          text,
          style: const TextStyle(
            fontSize: Sizes.size10,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
