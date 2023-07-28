import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v40,
                    const Text(
                      'Watch videos',
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v40,
                    const Text(
                      'Watch videos',
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v40,
                    const Text(
                      'Watch videos',
                      style: TextStyle(
                        fontSize: Sizes.size40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      'Videos are personalized for you based on what you watch, like, and share.',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            surfaceTintColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabPageSelector(
                  selectedColor: Theme.of(context).primaryColor,
                )
              ],
            )),
      ),
    );
  }
}
