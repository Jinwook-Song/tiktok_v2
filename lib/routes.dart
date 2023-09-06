import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/features/authentication/login_screen.dart';
import 'package:tiktok_v2/features/authentication/sign_up_screen.dart';
import 'package:tiktok_v2/features/onboarding/interests_screen.dart';
import 'package:tiktok_v2/features/user/user_profile_screen.dart';

enum ScreenDef { name, path }

class Routes {
  static const signupScreen = {
    ScreenDef.name: 'Sign Up',
    ScreenDef.path: '/',
  };
  static const loginScreen = {
    ScreenDef.name: 'Log In',
    ScreenDef.path: '/login',
  };
  static const interestsScreen = {
    ScreenDef.name: 'Interests',
    ScreenDef.path: '/tutorial',
  };

  static const videoRecordingScreen = {
    ScreenDef.name: 'Viedo Recording',
    ScreenDef.path: '/video-recording',
  };
}

final router = GoRouter(
  routes: [
    GoRoute(
      name: Routes.signupScreen[ScreenDef.name],
      path: Routes.signupScreen[ScreenDef.path]!,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: Routes.loginScreen[ScreenDef.name],
      path: Routes.loginScreen[ScreenDef.path]!,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: Routes.interestsScreen[ScreenDef.name],
      path: Routes.interestsScreen[ScreenDef.path]!,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      path: '/users/:username',
      builder: (context, state) {
        final username = state.pathParameters['username'];
        final tab = state.uri.queryParameters['show'];
        return UserProfileScreen(
          username: username,
          tab: tab,
        );
      },
    ),
  ],
);
