import 'package:connectly/features/authentication/data/datasources/firebase_auth_data_source.dart';
import 'package:connectly/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:connectly/features/authentication/domain/entities/app_user.dart';
import 'package:connectly/features/authentication/domain/repositories/auth_repository.dart';
import 'package:connectly/features/authentication/domain/usecases/get_auth_state.dart';
import 'package:connectly/features/authentication/domain/usecases/send_email_verification.dart';
import 'package:connectly/features/authentication/domain/usecases/send_password_reset_email.dart';
import 'package:connectly/features/authentication/domain/usecases/sign_in_with_email.dart';
import 'package:connectly/features/authentication/domain/usecases/sign_out.dart';
import 'package:connectly/features/authentication/domain/usecases/sign_up_with_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Provides the Firebase Authentication instance.
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provides the Firebase Authentication data source.
final firebaseAuthDataSourceProvider =
Provider<FirebaseAuthDataSource>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);

  return FirebaseAuthDataSource(firebaseAuth);
});

/// Provides the authentication repository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.watch(firebaseAuthDataSourceProvider);

  return AuthRepositoryImpl(dataSource);
});

/// Registration use case.
final signUpWithEmailProvider = Provider<SignUpWithEmail>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return SignUpWithEmail(repository);
});

/// Login use case.
final signInWithEmailProvider = Provider<SignInWithEmail>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return SignInWithEmail(repository);
});

/// Email verification use case.
final sendEmailVerificationProvider =
Provider<SendEmailVerification>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return SendEmailVerification(repository);
});

/// Password reset use case.
final sendPasswordResetEmailProvider =
Provider<SendPasswordResetEmail>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return SendPasswordResetEmail(repository);
});

/// Sign-out use case.
final signOutProvider = Provider<SignOut>((ref) {
  final repository = ref.watch(authRepositoryProvider);

  return SignOut(repository);
});

/// Authentication state stream.
final authStateProvider = StreamProvider<AppUser?>((ref) {
  final getAuthState = GetAuthState(
    ref.watch(authRepositoryProvider),
  );

  return getAuthState();
});