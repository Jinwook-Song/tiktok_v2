import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/main_navigation/main_navigation_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TikTok',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFE9435A),
          ),
          appBarTheme: const AppBarTheme(
              foregroundColor: Colors.black,
              shadowColor: Colors.black,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w700,
              )),
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w400,
            ),
          ),
          tabBarTheme: const TabBarTheme(
            dividerColor: Colors.transparent,
          ),
          splashColor: Colors.transparent,
        ),
        home: const MainNavigationScreen());
  }
}
