import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/birthday_screen.dart';
import 'package:tiktok_v2/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = '';
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    // add event listeners
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  List<bool> _isPasswordValid() {
    bool lengthCheck = false;
    bool combinationCheck = false;
    final regExp = RegExp(r"(?=.*\d)(?=.*[a-zA-Z])(?=.*\W)");

    if (_password.length >= 8 && _password.length <= 20) {
      lengthCheck = true;
    } else {
      lengthCheck = false;
    }

    if (regExp.hasMatch(_password)) {
      combinationCheck = true;
    } else {
      combinationCheck = false;
    }

    return [lengthCheck, combinationCheck];
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_isPasswordValid()[0] && _isPasswordValid()[1]) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),);
    }
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign up')),
        body: Padding(
          padding: const EdgeInsets.all(Sizes.size28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create password',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v20,
              TextField(
                controller: _passwordController,
                onEditingComplete: _onSubmit,
                autocorrect: false,
                autofocus: true,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: Icon(
                          FontAwesomeIcons.solidCircleXmark,
                          size: Sizes.size16,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: Icon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: Sizes.size16,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Gaps.h16,
                    ],
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w400,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: Sizes.size2,
                    ),
                  ),
                ),
              ),
              Gaps.v10,
              const Text(
                'Your password must have:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size14,
                    color: _isPasswordValid()[0]
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h6,
                  const Text(
                    '8 to 20 characters',
                    style: TextStyle(
                      fontSize: Sizes.size12,
                    ),
                  ),
                ],
              ),
              Gaps.v2,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size14,
                    color: _isPasswordValid()[1]
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h6,
                  const Text(
                    'Letters, numbers, and special characters',
                    style: TextStyle(
                      fontSize: Sizes.size12,
                    ),
                  ),
                ],
              ),
              Gaps.v20,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: !_isPasswordValid()[0] || !_isPasswordValid()[1],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
