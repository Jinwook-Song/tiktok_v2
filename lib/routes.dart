import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/features/authentication/email_screen.dart';
import 'package:tiktok_v2/features/authentication/login_screen.dart';
import 'package:tiktok_v2/features/authentication/sign_up_screen.dart';
import 'package:tiktok_v2/features/authentication/username_screen.dart';
import 'package:tiktok_v2/features/user/user_profile_screen.dart';

class Routes {
  static const signupScreen = '/';
  static const loginScreen = '/login';
  static const userNameScreen = '/username';
  static const emailScreen = '/email';
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.signupScreen,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: Routes.loginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.userNameScreen,
      builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      path: Routes.emailScreen,
      builder: (context, state) => const EmailScreen(),
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
