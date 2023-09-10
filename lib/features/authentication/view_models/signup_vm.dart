import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';
import 'package:tiktok_v2/routes.dart';
import 'package:tiktok_v2/utils.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authProvider);
  }

  Future<void> signUpWithEmailAndPassword(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpFormProvider);
    state = await AsyncValue.guard(
      () async => await _authRepo.signUpWithEmailAndPassword(
        email: form['email'],
        password: form['password'],
      ),
    );
    if (state.hasError) {
      showFirebaseErrorSnackBar(context, state.error);
    } else {
      context.goNamed(Routes.interestsScreen[ScreenDef.name]!);
    }
  }
}

final signUpFormProvider = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
