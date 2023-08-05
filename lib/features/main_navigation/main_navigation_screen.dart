import 'package:flutter/material.dart';

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
    return Scaffold(
      body: _screens[_currentIndex],
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
    );
  }
}


// Material 2 Bottom Navigation Bar
// bottomNavigationBar: BottomNavigationBar(
//   type: BottomNavigationBarType.shifting,
//   currentIndex: _currentIndex,
//   onTap: _onBottomNavigationTap,
//   items: const [
//     BottomNavigationBarItem(
//       icon: FaIcon(FontAwesomeIcons.house),
//       label: 'house',
//       tooltip: 'Main',
//       backgroundColor: Colors.amber,
//     ),
//     BottomNavigationBarItem(
//       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
//       label: 'search',
//       backgroundColor: Colors.pink,
//     ),
//     BottomNavigationBarItem(
//       icon: FaIcon(FontAwesomeIcons.message),
//       label: 'chat',
//       backgroundColor: Colors.purple,
//     ),
//   ],
// ),