import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/common/widgets/theme_config/theme_config.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ValueListenableBuilder(
      valueListenable: useDarkTheme,
      builder: (context, isDark, child) => Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              width: Sizes.size1,
            ),
          ),
        ),
        child: TabBar(
          splashFactory: NoSplash.splashFactory,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: Sizes.size1,
          indicatorColor: Theme.of(context).primaryColor,
          labelPadding: const EdgeInsets.symmetric(vertical: Sizes.size10),
          tabs: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
              child: Icon(Icons.grid_3x3_outlined),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
              child: Icon(FontAwesomeIcons.heart),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 45;

  @override
  double get minExtent => 45;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
