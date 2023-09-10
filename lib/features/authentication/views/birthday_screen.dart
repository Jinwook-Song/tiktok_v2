import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';
import 'package:tiktok_v2/features/authentication/views/widgets/form_button.dart';
import 'package:tiktok_v2/routes.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
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
    context.pushReplacementNamed(Routes.interestsScreen[ScreenDef.name]!);
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => const InterestsScreen(),
    //   ),
    //   (route) => false,
    // );
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
                child: const FormButton(disabled: false),
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
