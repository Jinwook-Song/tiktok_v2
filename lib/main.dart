import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/generated/l10n.dart';
import 'package:tiktok_v2/routes.dart';

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
    // S.load(const Locale('en'));
    return MaterialApp.router(
      routerConfig: router,
      title: 'TikTok',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ko'),
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: Typography.blackCupertino,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: const Color(0xFFE9435A),
        ),
        primaryColor: const Color(0xFFE9435A),
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
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w400,
          ),
        ),
        tabBarTheme: TabBarTheme(
          dividerColor: Colors.transparent,
          indicatorColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          labelColor: Colors.black,
        ),
        splashColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        textTheme: Typography.whiteCupertino,
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
          iconTheme: IconThemeData(color: Color.fromRGBO(255, 255, 255, 0.99)),
          actionsIconTheme:
              IconThemeData(color: Color.fromRGBO(255, 255, 255, 0.99)),
        ),
        iconTheme:
            const IconThemeData(color: Color.fromRGBO(255, 255, 255, 0.99)),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.white,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
          surfaceTintColor: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontWeight: FontWeight.w400,
          ),
        ),
        tabBarTheme: TabBarTheme(
          dividerColor: Colors.transparent,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade500,
          labelColor: Colors.white,
        ),
        splashColor: Colors.transparent,
      ),
    );
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
