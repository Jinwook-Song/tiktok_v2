import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;

  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor ?? Colors.white,
          size: Sizes.size32,
        ),
        Gaps.v5,
        Text(
          text,
          style: TextStyle(
            fontSize: Sizes.size10,
            color: iconColor ?? Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
