import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/onboarding/widgets/interests_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden",
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _showHeader = false;

  @override
  void initState() {
    super.initState();
    _onScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _scrollController.addListener(() {
      if (_scrollController.offset > 110) {
        if (_showHeader) return;
        _showHeader = true;
        setState(() {});
      } else {
        _showHeader = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: AnimatedOpacity(
            opacity: _showHeader ? 1 : 0,
            duration: const Duration(milliseconds: 150),
            child: const Text('Choose your interests')),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                const Text(
                  'Choose your interests',
                  style: TextStyle(
                    fontSize: Sizes.size40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v16,
                Text(
                  'Get better video recommendations',
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.grey.shade800,
                  ),
                ),
                Gaps.v64,
                Wrap(
                  spacing: Sizes.size12,
                  runSpacing: Sizes.size20,
                  children: [
                    for (var interest in interests)
                      InterestsButton(interest: interest)
                  ],
                ),
                Gaps.v48,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        elevation: 1,
        child: CupertinoButton(
          onPressed: () {},
          color: Theme.of(context).primaryColor,
          child: const Text('Next'),
        ),
      ),
    );
  }
}
