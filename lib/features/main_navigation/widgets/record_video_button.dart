import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class RecordVideoButton extends StatelessWidget {
  const RecordVideoButton({
    super.key,
    required this.isHomeTab,
  });

  final bool isHomeTab;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 17,
          child: Container(
            width: 25,
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xff61D4F0),),
          ),
        ),
        Positioned(
          left: 17,
          child: Container(
            width: 25,
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).primaryColor,),
          ),
        ),
        Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size10),
          decoration: BoxDecoration(
            color: isHomeTab ? Colors.white : Colors.black,
            borderRadius: BorderRadius.circular(Sizes.size6),
          ),
          child: Center(
            child: Icon(
              FontAwesomeIcons.plus,
              color: isHomeTab ? Colors.black : Colors.white,
              size: 18,
            ),
          ),
        )
      ],
    );
  }
}
