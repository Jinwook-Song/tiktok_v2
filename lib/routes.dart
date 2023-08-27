import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/features/authentication/email_screen.dart';
import 'package:tiktok_v2/features/authentication/login_screen.dart';
import 'package:tiktok_v2/features/authentication/username_screen.dart';
import 'package:tiktok_v2/features/user/user_profile_screen.dart';
import 'package:tiktok_v2/features/videos/video_recording_screen.dart';

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
  static const userNameScreen = {
    ScreenDef.name: 'Username',
    ScreenDef.path: '/username',
  };
  static const emailScreen = {
    ScreenDef.name: 'Email',
    ScreenDef.path: '/email',
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
      builder: (context, state) => const VideoRecordingScreen(),
    ),
    GoRoute(
      name: Routes.loginScreen[ScreenDef.name],
      path: Routes.loginScreen[ScreenDef.path]!,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: Routes.userNameScreen[ScreenDef.name],
      path: Routes.userNameScreen[ScreenDef.path]!,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: const UsernameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: child,
            ),
          ),
        );
      },
      // builder: (context, state) => const UsernameScreen(),
    ),
    GoRoute(
      name: Routes.emailScreen[ScreenDef.name],
      path: Routes.emailScreen[ScreenDef.path]!,
      builder: (context, state) {
        final args = state.extra as EmailScreenArgs;
        return EmailScreen(username: args.username);
      },
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
