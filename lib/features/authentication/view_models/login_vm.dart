import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/utils.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late AuthRepo _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authProvider);
  }

  Future<void> loginWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );

    if (state.hasError) {
      showFirebaseErrorSnackBar(context, state.error);
    } else {
      context.go('/home');
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
