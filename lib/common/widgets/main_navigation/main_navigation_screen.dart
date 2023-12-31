import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/features/discover/discover_screen.dart';
import 'package:tiktok_v2/features/inbox/views/inbox_screen.dart';
import 'package:tiktok_v2/common/widgets/main_navigation/widgets/navigation_tab.dart';
import 'package:tiktok_v2/common/widgets/main_navigation/widgets/record_video_button.dart';
import 'package:tiktok_v2/features/user/views/user_profile_screen.dart';
import 'package:tiktok_v2/features/videos/views/video_timeline_screen.dart';
import 'package:tiktok_v2/routes.dart';
import 'package:tiktok_v2/utils.dart';

const List<String> _tabs = [
  'home',
  'discover',
  '_',
  'inbox',
  'profile',
];

class MainNavigationScreen extends StatefulWidget {
  final String tab;
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex = _tabs.indexOf(widget.tab);
  late bool _isHomeTab = _currentIndex == 0 ? true : false;

  void _onBottomNavigationTap(int tab) {
    if (tab == 2) return;
    context.go('/${_tabs[tab]}');
    setState(() {
      _currentIndex = tab;
      _isHomeTab = (tab == 0);
    });
  }

  void _onRecordVideoTap() {
    context.pushNamed(Routes.videoRecordingScreen[ScreenDef.name]!);
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => Scaffold(
    //       appBar: AppBar(
    //         title: const Text('Record Video'),
    //       ),
    //     ),
    //     fullscreenDialog: true,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // keyboard에 의해 스크린 사이즈가 제조정되지 않도록
      resizeToAvoidBottomInset: false,
      backgroundColor: _currentIndex == 0 || isDarkMode(context)
          ? Colors.black
          : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _currentIndex != 0,
            child: VideoTimelineScreen(
              isActivated: _currentIndex == 0,
            ),
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _currentIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _currentIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: _isHomeTab || isDarkMode(context) ? Colors.black : Colors.white,
        surfaceTintColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationTab(
              icon: FontAwesomeIcons.house,
              selectedIcon: FontAwesomeIcons.house,
              lable: 'Home',
              isSelected: _currentIndex == 0,
              isHomeTab: _isHomeTab,
              onTap: () => _onBottomNavigationTap(0),
            ),
            NavigationTab(
              icon: FontAwesomeIcons.compass,
              selectedIcon: FontAwesomeIcons.solidCompass,
              lable: 'Discover',
              isSelected: _currentIndex == 1,
              isHomeTab: _isHomeTab,
              onTap: () => _onBottomNavigationTap(1),
            ),
            Gaps.h20,
            GestureDetector(
              onTap: _onRecordVideoTap,
              child: RecordVideoButton(
                isHomeTab: _isHomeTab,
              ),
            ),
            Gaps.h20,
            NavigationTab(
              icon: FontAwesomeIcons.message,
              selectedIcon: FontAwesomeIcons.solidMessage,
              lable: 'Inbox',
              isSelected: _currentIndex == 3,
              isHomeTab: _isHomeTab,
              onTap: () => _onBottomNavigationTap(3),
            ),
            NavigationTab(
              icon: FontAwesomeIcons.user,
              selectedIcon: FontAwesomeIcons.solidUser,
              lable: 'Profile',
              isSelected: _currentIndex == 4,
              isHomeTab: _isHomeTab,
              onTap: () => _onBottomNavigationTap(4),
            ),
          ],
        ),
      ),
    );
  }
}


/* Material 2 Bottom Navigation Bar
bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.shifting,
  currentIndex: _currentIndex,
  onTap: _onBottomNavigationTap,
  items: const [
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.house),
      label: 'house',
      tooltip: 'Main',
      backgroundColor: Colors.amber,
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
      label: 'search',
      backgroundColor: Colors.pink,
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.message),
      label: 'chat',
      backgroundColor: Colors.purple,
    ),
  ],
), */

/* Material 3  Navigation Bar
bottomNavigationBar: NavigationBar(
  onDestinationSelected: _onBottomNavigationTap,
  selectedIndex: _currentIndex,
  labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
  destinations: const [
    NavigationDestination(
      icon: Icon(Icons.house_outlined),
      selectedIcon: Icon(Icons.house),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search),
      label: 'Search',
    ),
    NavigationDestination(
      icon: Icon(Icons.chat_outlined),
      selectedIcon: Icon(Icons.chat),
      label: 'Chat',
    ),
  ],
  ),
); */

/* Cupertino Navigation Bar
return CupertinoTabScaffold(
  tabBar: CupertinoTabBar(items: const [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.house_alt_fill),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      label: 'Search',
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.text_bubble),
      label: 'Chat',
    ),
  ]),
  tabBuilder: (context, index) => _screens[index],
); */

