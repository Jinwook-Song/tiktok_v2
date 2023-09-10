import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_v2/common/widgets/theme_config/theme_config.dart';

bool isDarkMode(BuildContext context) {
  return useDarkTheme.value;
}

void showFirebaseErrorSnackBar(
  BuildContext context,
  Object? error,
) {
  final snackBar = SnackBar(
    showCloseIcon: true,
    content: Text(
      (error as FirebaseException).message ?? 'Something went wrong',
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
