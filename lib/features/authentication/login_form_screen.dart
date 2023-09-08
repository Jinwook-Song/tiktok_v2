import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/widgets/form_button.dart';
import 'package:tiktok_v2/routes.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _onSubmitTap() {
    // validate(save) all of fields at once
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState!.save();
      context.goNamed(Routes.interestsScreen[ScreenDef.name]!);
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (context) => const InterestsScreen(),
      //   ),
      //   // 이전 경로를 기억할 지 선택
      //   (route) => false,
      // );
    }
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(title: const Text('Log in')),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size28),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Gaps.v40,
                TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    // TODO: validate
                    if (value?.isNotEmpty == true) return null;
                    return 'user not found';
                  },
                  onSaved: (newValue) {
                    _formData['email'] = newValue!;
                  },
                ),
                Gaps.v16,
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    // TODO: validate
                    if (value?.isNotEmpty == true) return null;
                    return 'wrong password';
                  },
                  onSaved: (newValue) {
                    _formData['password'] = newValue!;
                  },
                ),
                Gaps.v40,
                GestureDetector(
                  onTap: _onSubmitTap,
                  child: const FormButton(
                    disabled: false,
                    text: 'Log in',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
