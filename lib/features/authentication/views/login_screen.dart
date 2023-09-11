import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/view_models/social_auth_vm.dart';
import 'package:tiktok_v2/features/authentication/views/login_form_screen.dart';
import 'package:tiktok_v2/features/authentication/views/widgets/auth_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  void _onSignupTap(BuildContext context) {
    context.pop();
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  void _onGithubSignIn(BuildContext context, WidgetRef ref) {
    ref.read(socialAuthProvider.notifier).signInWithGitHub(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                'Log in to TikTok',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.v20,
              Text(
                'Manage your account, check notifications, comment on videos, and more.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.grey.shade500,
                    ),
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onEmailTap(context),
                child: const AuthButton(
                  text: 'Use email & password',
                  icon: Icon(FontAwesomeIcons.user),
                ),
              ),
              Gaps.v16,
              const AuthButton(
                text: 'Continue with Apple',
                icon: Icon(FontAwesomeIcons.apple),
              ),
              Gaps.v16,
              GestureDetector(
                onTap: () => _onGithubSignIn(context, ref),
                child: const AuthButton(
                  text: 'Continue with Github',
                  icon: Icon(FontAwesomeIcons.github),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Don\'t have an account?',
            ),
            Gaps.h10,
            GestureDetector(
              onTap: () => _onSignupTap(context),
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
