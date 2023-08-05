import 'package:flutter/cupertino.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Chat'),
    ),
  ];

  void _onBottomNavigationTap(int tab) {
    _currentIndex = tab;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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

