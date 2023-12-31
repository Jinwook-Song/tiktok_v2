import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class CustimScrollViewSample extends StatelessWidget {
  const CustimScrollViewSample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // snap: true, // appbar가 즉시 내려오도록
          // floating: true, // Scroll Up하는동안 appbar가 보이도록
          pinned: true, // appbar 고정
          stretch: true, // 최 상단에서 Scroll Up할때, appbar가 늘어남
          backgroundColor: Colors.amber,
          collapsedHeight: 80,
          expandedHeight: 300,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
              // StretchMode.fadeTitle,
            ],
            title: const Text('Hello'),
            background: Image.asset(
              'assets/images/placeholder.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 40,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 10)],
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Item: $index',
                ),
              ),
            ),
          ),
          itemExtent: 100,
        ),
        SliverPersistentHeader(
          pinned: true,
          // floating: true,
          delegate: CustomPersistentheader(),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 40,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 10)],
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Item: $index',
                ),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
          ),
        )
      ],
    );
  }
}

class CustomPersistentheader extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent,) {
    return Container(
      color: Colors.redAccent,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(child: Text('Persistent Header')),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
