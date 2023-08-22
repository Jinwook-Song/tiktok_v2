import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/settings/settings_screen.dart';
import 'package:tiktok_v2/features/user/widgets/persistent_tab_bar.dart';
import 'package:tiktok_v2/utils.dart';

class UserProfileScreen extends StatefulWidget {
  final String? username;
  const UserProfileScreen({
    super.key,
    this.username,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onSettingsTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode(context) ? Colors.grey.shade900 : null,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor:
                      isDarkMode(context) ? Colors.grey.shade900 : null,
                  title: Text(widget.username ?? 'Anonymous'),
                  actions: [
                    IconButton(
                      onPressed: _onSettingsTap,
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
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: const Text(
                              'Follow',
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
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
                              highlightColor: Colors.transparent,
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.youtube,
                                size: Sizes.size24,
                                color: isDarkMode(context)
                                    ? Colors.white
                                    : Colors.black,
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
                              highlightColor: Colors.transparent,
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.caretDown,
                                size: Sizes.size16,
                                color: isDarkMode(context)
                                    ? Colors.white
                                    : Colors.black,
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
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: PersistentTabBar(),
                )
              ];
            },
            body: TabBarView(
              children: [
                GridView.builder(
                  padding: EdgeInsets.zero,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 50,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Sizes.size2,
                    mainAxisSpacing: Sizes.size2,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (context, index) => Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/placeholder.jpeg',
                          image: "https://source.unsplash.com/random/?$index",
                        ),
                      ),
                      const Positioned(
                        bottom: 6,
                        left: 6,
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.circlePlay,
                              color: Colors.white,
                              size: Sizes.size16,
                            ),
                            Gaps.h2,
                            Text(
                              '4.1M',
                              style: TextStyle(
                                fontSize: Sizes.size12,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Center(
                  child: Text('Page Two'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
