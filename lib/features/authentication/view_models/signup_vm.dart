import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_v2/features/authentication/repos/auth_repo.dart';

class SignupViewModel extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authProvider);
  }

  Future<void> signUpWithEmailAndPassword() async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpFormProvider);
    state = await AsyncValue.guard(
      () async => await _authRepo.signUpWithEmailAndPassword(
        email: form['email'],
        password: form['password'],
      ),
    );
  }
}

final signUpFormProvider = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignupViewModel, void>(
  () => SignupViewModel(),
);
