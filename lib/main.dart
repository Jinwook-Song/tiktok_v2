import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 세로 화면 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // 상단 바 컬러, 각 화면 마다 설정 할 수 있다.
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TikTok',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.itimTextTheme(),
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.light,
            seedColor: const Color(0xFFE9435A),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            shadowColor: Colors.black,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade100,
            surfaceTintColor: Colors.white,
          ),
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
        darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.itimTextTheme(
              ThemeData(brightness: Brightness.dark).textTheme),
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: const Color(0xFFE9435A),
          ),
          primaryColor: const Color(0xFFE9435A),
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white,
            shadowColor: Colors.white,
            surfaceTintColor: Colors.black,
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w700,
            ),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
            surfaceTintColor: Colors.white,
          ),
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
        home: const SignUpScreen());
  }
}

/* Layout builder는 해당 위젯이 가질 수 있는 최대 크기를 알 있다.
class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FractionallySizedBox(
        widthFactor: 1 / 2,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.amber,
            alignment: Alignment.center,
            child: Text(
              '$width / ${constraints.maxWidth}',
              style: const TextStyle(
                fontSize: Sizes.size20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/
