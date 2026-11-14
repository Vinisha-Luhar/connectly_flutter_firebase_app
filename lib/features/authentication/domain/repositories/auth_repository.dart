
import '../entities/app_user.dart';

abstract interface class AuthRepository {
  /// Returns the currently authenticated user, if available.
  AppUser? get currentUser;

  /// Emits authentication state changes.
  Stream<AppUser?> get authStateChanges;

  /// Creates an account using email and password.
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
  });

  /// Signs in using email and password.
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  });

  /// Signs in using Google.
  Future<AppUser> signInWithGoogle();

  /// Sends an email verification link.
  Future<void> sendEmailVerification();

  /// Sends a password reset email.
  Future<void> sendPasswordResetEmail({
    required String email,
  });

  /// Signs out the currently authenticated user.
  Future<void> signOut();
}
