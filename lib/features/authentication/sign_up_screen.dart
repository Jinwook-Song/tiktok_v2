import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/username_screen.dart';
import 'package:tiktok_v2/features/authentication/login_screen.dart';
import 'package:tiktok_v2/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
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
                    'Sign up for TikTok',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Gaps.v20,
                  Text(
                    'Create a profile, follow other accounts, make your own videos, and more.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.grey.shade500,
                        ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      text: 'Use email & password',
                      icon: const Icon(FontAwesomeIcons.user),
                      onAuthButtonTap: () => _onEmailTap(context),
                    ),
                    Gaps.v16,
                    const AuthButton(
                      text: 'Continue with Apple',
                      icon: Icon(FontAwesomeIcons.apple),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            text: 'Use email & password',
                            icon: const Icon(FontAwesomeIcons.user),
                            onAuthButtonTap: () => _onEmailTap(context),
                          ),
                        ),
                        Gaps.h16,
                        const Expanded(
                          child: AuthButton(
                            text: 'Continue with Apple',
                            icon: Icon(FontAwesomeIcons.apple),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            // surfaceTintColor: Colors.grey.shade200,
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                ),
                Gaps.h10,
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    'Log in',
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
      },
    );
  }
}
