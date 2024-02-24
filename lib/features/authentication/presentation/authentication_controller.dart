import 'dart:async';
import 'package:noteworthy/features/authentication/data/authentication_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_controller.g.dart';

@riverpod
class AuthenticationContorller extends _$AuthenticationContorller {
  // initial value
  @override
  // FutureOr represents values that are Future<T> or T
  FutureOr<void> build() {
    // nothing to do
  }

  // Sign in
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
        () => authRepository.signInWithEmailAndPassword(email, password));
    return state.hasError == false;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String username,
  }) async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => authRepository
        .createUserWithEmailAndPassword(email, password, username));
    return state.hasError == false;
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }

  // Sign up
}
