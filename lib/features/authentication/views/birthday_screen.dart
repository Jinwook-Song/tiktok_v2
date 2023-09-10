import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/view_models/signup_vm.dart';
import 'package:tiktok_v2/features/authentication/views/widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => BirthdayScreenState();
}

class BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _convertDateTimeToString(today);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    ref.read(signUpProvider.notifier).signUpWithEmailAndPassword();
    // context.pushReplacementNamed(Routes.interestsScreen[ScreenDef.name]!);
  }

  void _convertDateTimeToString(DateTime date) {
    final dateToString = date.toString().split(' ')[0];
    _birthdayController.value = TextEditingValue(text: dateToString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'When\'s your birthday?',
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v8,
              Text(
                'Your birthday won\'t be shown publicly.',
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
              Gaps.v20,
              TextField(
                controller: _birthdayController,
                autofocus: true,
                enabled: false,
                decoration: InputDecoration(
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
              Gaps.v20,
              GestureDetector(
                onTap: _onNextTap,
                child: FormButton(
                  disabled: ref.watch(signUpProvider).isLoading,
                ),
              ),
              Gaps.v60,
              SizedBox(
                height: 300,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: today,
                  maximumDate: today,
                  onDateTimeChanged: _convertDateTimeToString,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
