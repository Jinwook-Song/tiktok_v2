import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_v2/generated/l10n.dart';
import 'package:tiktok_v2/routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    context.push(Routes.loginScreen);
  }

  void _onEmailTap(BuildContext context) {
    context.push(Routes.userNameScreen);

    // Navigator.of(context).pushNamed(Routes.userNameScreen);

    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(milliseconds: 300),
    //     reverseTransitionDuration: const Duration(milliseconds: 300),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     transitionsBuilder: (
    //       context,
    //       animation,
    //       secondaryAnimation,
    //       child,
    //     ) {
    //       final offsetAnimation = Tween(
    //         begin: const Offset(0, 1),
    //         end: Offset.zero,
    //       ).animate(
    //         animation,
    //       );

    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),
    // );
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
