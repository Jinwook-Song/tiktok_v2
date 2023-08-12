import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Jinwook'),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.gear,
                  size: Sizes.size20,
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  foregroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/78011042?v=4',
                  ),
                  child: Text('Jinwook'),
                ),
                Gaps.v16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '@Jinwook',
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gaps.h3,
                    Icon(
                      FontAwesomeIcons.solidCircleCheck,
                      size: Sizes.size12,
                      color: Colors.cyan.withOpacity(0.6),
                    )
                  ],
                ),
                Gaps.v20,
                SizedBox(
                  height: Sizes.size56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            '37',
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        width: Sizes.size32,
                        thickness: Sizes.size1,
                        indent: Sizes.size16,
                        endIndent: Sizes.size16,
                        color: Colors.grey.shade300,
                      ),
                      Column(
                        children: [
                          const Text(
                            '10.5M',
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      VerticalDivider(
                        width: Sizes.size32,
                        thickness: Sizes.size1,
                        indent: Sizes.size16,
                        endIndent: Sizes.size16,
                        color: Colors.grey.shade300,
                      ),
                      Column(
                        children: [
                          const Text(
                            '149.3M',
                            style: TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Likes',
                            style: TextStyle(
                              fontSize: Sizes.size16,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Gaps.v16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Sizes.size44 * 4,
                      height: Sizes.size44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(2)),
                      child: const Text(
                        'Follow',
                        style: TextStyle(
                            fontSize: Sizes.size16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Gaps.h4,
                    Container(
                      width: Sizes.size44,
                      height: Sizes.size44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.youtube,
                          size: Sizes.size24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Gaps.h4,
                    Container(
                      width: Sizes.size44,
                      height: Sizes.size44,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const FaIcon(
                          FontAwesomeIcons.caretDown,
                          size: Sizes.size16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.v16,
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Sizes.size32,
                  ),
                  child: Text(
                    'All highlights and where to watch live matches on FIFA+',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Gaps.v16,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.link,
                      size: Sizes.size16,
                    ),
                    Gaps.h10,
                    Text(
                      'https://github.com/Jinwook-Song/tiktok_v2',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                Gaps.v16,
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: Colors.grey.shade200,
                        width: Sizes.size1,
                      ),
                    ),
                  ),
                  child: TabBar(
                    splashFactory: NoSplash.splashFactory,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: Sizes.size1,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelPadding:
                        const EdgeInsets.symmetric(vertical: Sizes.size10),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
