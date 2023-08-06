import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/features/main_navigation/widgets/navigation_tab.dart';
import 'package:tiktok_v2/features/main_navigation/widgets/record_video_button.dart';
import 'package:tiktok_v2/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const VideoTimelineScreen(),
    const Center(
      child: Text('Discover'),
    ),
    const Center(
      child: Text('Record Video'),
    ),
    const Center(
      child: Text('Inbox'),
    ),
    const Center(
      child: Text('Profile'),
    ),
  ];

  void _onBottomNavigationTap(int tab) {
    _currentIndex = tab;
    setState(() {});
  }

  void _onRecordVideoTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: const Text('Record Video'),
        ),
      ),
      fullscreenDialog: true,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _currentIndex != 0,
            child: _screens[_currentIndex],
          ),
          Offstage(
            offstage: _currentIndex != 1,
            child: _screens[_currentIndex],
          ),
          Offstage(
            offstage: _currentIndex != 3,
            child: _screens[_currentIndex],
          ),
          Offstage(
            offstage: _currentIndex != 4,
            child: _screens[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavigationTab(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                lable: 'Home',
                isSelected: _currentIndex == 0,
                onTap: () => _onBottomNavigationTap(0),
              ),
              NavigationTab(
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                lable: 'Discover',
                isSelected: _currentIndex == 1,
                onTap: () => _onBottomNavigationTap(1),
              ),
              Gaps.h20,
              GestureDetector(
                onTap: _onRecordVideoTap,
                child: const RecordVideoButton(),
              ),
              Gaps.h20,
              NavigationTab(
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                lable: 'Inbox',
                isSelected: _currentIndex == 3,
                onTap: () => _onBottomNavigationTap(3),
              ),
              NavigationTab(
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                lable: 'Profile',
                isSelected: _currentIndex == 4,
                onTap: () => _onBottomNavigationTap(4),
              ),
            ],
          )),
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

