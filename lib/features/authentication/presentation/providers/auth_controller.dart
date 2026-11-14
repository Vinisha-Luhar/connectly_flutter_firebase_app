import 'package:connectly/features/authentication/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AuthController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  /// Register a new user.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(signUpWithEmailProvider)(
        email: email,
        password: password,
      );
    });
  }

  /// Sign in an existing user.
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(signInWithEmailProvider)(
        email: email,
        password: password,
      );
    });
  }

  /// Send email verification.
  Future<void> sendEmailVerification() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(sendEmailVerificationProvider)();
    });
  }

  /// Request password reset.
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(sendPasswordResetEmailProvider)(
        email: email,
      );
    });
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(signOutProvider)();
    });
  }
}

/// Provides the authentication controller.
final authControllerProvider =
AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);