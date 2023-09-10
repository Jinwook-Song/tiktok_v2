import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/view_models/login_vm.dart';
import 'package:tiktok_v2/features/authentication/views/widgets/form_button.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  ConsumerState<LoginFormScreen> createState() => LoginFormScreenState();
}

class LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _onSubmitTap() {
    // validate(save) all of fields at once
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState!.save();
      print(_formData);
      ref.read(loginProvider.notifier).loginWithEmailAndPassword(
            context: context,
            email: _formData['email']!,
            password: _formData['password']!,
          );
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
                  child: FormButton(
                    disabled: ref.watch(loginProvider).isLoading,
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
