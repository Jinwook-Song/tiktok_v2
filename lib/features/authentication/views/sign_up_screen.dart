import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/view_models/social_auth_vm.dart';
import 'package:tiktok_v2/features/authentication/views/username_screen.dart';
import 'package:tiktok_v2/features/authentication/views/widgets/auth_button.dart';
import 'package:tiktok_v2/generated/l10n.dart';
import 'package:tiktok_v2/routes.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    context.pushNamed(Routes.loginScreen[ScreenDef.name]!);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  void _onGithubSignIn(BuildContext context, WidgetRef ref) {
    ref.read(socialAuthProvider.notifier).signInWithGitHub(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    S.of(context).signUpTitle('TikTok', DateTime.now()),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Gaps.v20,
                  Text(
                    S.of(context).signUpSubtitle(2),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                    Gaps.v16,
                    GestureDetector(
                      onTap: () => _onGithubSignIn(context, ref),
                      child: const AuthButton(
                        text: 'Continue with Github',
                        icon: Icon(FontAwesomeIcons.github),
                      ),
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
