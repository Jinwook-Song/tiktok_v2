import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class NavigationTab extends StatelessWidget {
  const NavigationTab({
    super.key,
    required this.lable,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.isHomeTab,
    required this.onTap,
  });
  final String lable;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final bool isHomeTab;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: AnimatedOpacity(
          opacity: isSelected ? 1 : 0.7,
          duration: const Duration(milliseconds: 150),
          child: Column(
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                color: isHomeTab ? Colors.white : Colors.black,
              ),
              Gaps.v4,
              Text(
                lable,
                style: TextStyle(
                  color: isHomeTab ? Colors.white : Colors.black,
                  fontSize: Sizes.size10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
