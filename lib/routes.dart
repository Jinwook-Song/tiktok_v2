import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/features/authentication/views/login_screen.dart';
import 'package:tiktok_v2/features/authentication/views/sign_up_screen.dart';
import 'package:tiktok_v2/features/inbox/activity_screen.dart';
import 'package:tiktok_v2/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_v2/features/inbox/chats_screen.dart';
import 'package:tiktok_v2/features/onboarding/interests_screen.dart';
import 'package:tiktok_v2/features/user/user_profile_screen.dart';
import 'package:tiktok_v2/features/videos/views/video_recording_screen.dart';

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
  static const mainScreen = {
    ScreenDef.name: 'Main',
    ScreenDef.path: '/:tab(home|discover|inbox|profile)',
  };
  static const activityScreen = {
    ScreenDef.name: 'Activity',
    ScreenDef.path: '/activity',
  };
  static const chatsScreen = {
    ScreenDef.name: 'Chats',
    ScreenDef.path: '/chats',
  };
  static const chatDetailScreen = {
    ScreenDef.name: 'Chat Detail',
    ScreenDef.path: ':chatId',
  };

  static const videoRecordingScreen = {
    ScreenDef.name: 'Viedo Recording',
    ScreenDef.path: '/video-recording',
  };
}

final routerProvider = Provider((ref) {
  // auth state에 변화가 생기면 Provider가 rebuild 된다.
  ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) {
      final isLoggedIn = ref.read(authProvider).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != Routes.signupScreen[ScreenDef.path] &&
            state.matchedLocation != Routes.loginScreen[ScreenDef.path]) {
          return Routes.signupScreen[ScreenDef.path];
        }
      }
      return null;
    },
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
        name: Routes.mainScreen[ScreenDef.name],
        path: Routes.mainScreen[ScreenDef.path]!,
        builder: (context, state) {
          final tab = state.pathParameters['tab']!;
          return MainNavigationScreen(tab: tab);
        },
      ),
      GoRoute(
        name: Routes.activityScreen[ScreenDef.name],
        path: Routes.activityScreen[ScreenDef.path]!,
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        name: Routes.chatsScreen[ScreenDef.name],
        path: Routes.chatsScreen[ScreenDef.path]!,
        builder: (context, state) => const ChatsScreen(),
        routes: [
          GoRoute(
            name: Routes.chatDetailScreen[ScreenDef.name],
            path: Routes.chatDetailScreen[ScreenDef.path]!,
            builder: (context, state) {
              final chatId = state.pathParameters['chatId']!;
              return ChatDetailScreen(
                chatId: chatId,
              );
            },
          )
        ],
      ),
      GoRoute(
        name: Routes.videoRecordingScreen[ScreenDef.name],
        path: Routes.videoRecordingScreen[ScreenDef.path]!,
        pageBuilder: (context, state) => CustomTransitionPage(
          child: const VideoRecordingScreen(),
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final position = Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(
              position: position,
              child: child,
            );
          },
        ),
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
});
