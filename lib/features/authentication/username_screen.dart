import 'package:flutter/material.dart';
import 'package:tiktok_v2/constants/gaps.dart';
import 'package:tiktok_v2/constants/sizes.dart';

class UsernameScreen extends StatelessWidget {
  const UsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.size28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create username',
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v8,
            Text(
              'You can always change this later.',
              style: TextStyle(
                color: Colors.grey.shade500,
              ),
            ),
            Gaps.v20,
            TextField(
              decoration: InputDecoration(
                hintText: 'Username',
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
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                    Sizes.size2,
                  ),
                ),
                child: const Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
