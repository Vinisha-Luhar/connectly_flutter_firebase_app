import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/errors/auth_failure.dart';

class FirebaseAuthErrorMapper {
  FirebaseAuthErrorMapper._();

  static AuthFailure map(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'email-already-in-use':
        return const AuthFailure(
          code: 'email-already-in-use',
          message: 'An account already exists with this email address.',
        );

      case 'invalid-email':
        return const AuthFailure(
          code: 'invalid-email',
          message: 'Please enter a valid email address.',
        );

      case 'weak-password':
        return const AuthFailure(
          code: 'weak-password',
          message: 'Your password is too weak. Please choose a stronger password.',
        );

      case 'user-not-found':
        return const AuthFailure(
          code: 'user-not-found',
          message: 'No account found with this email address.',
        );

      case 'wrong-password':
      case 'invalid-credential':
        return const AuthFailure(
          code: 'invalid-credentials',
          message: 'The email or password is incorrect.',
        );

      case 'user-disabled':
        return const AuthFailure(
          code: 'user-disabled',
          message: 'This account has been disabled.',
        );

      case 'too-many-requests':
        return const AuthFailure(
          code: 'too-many-requests',
          message: 'Too many attempts. Please try again later.',
        );

      case 'network-request-failed':
        return const AuthFailure(
          code: 'network-request-failed',
          message: 'Network error. Please check your internet connection.',
        );

      case 'operation-not-allowed':
        return const AuthFailure(
          code: 'operation-not-allowed',
          message: 'This authentication method is currently unavailable.',
        );

      case 'requires-recent-login':
        return const AuthFailure(
          code: 'requires-recent-login',
          message: 'Please sign in again before performing this operation.',
        );

      default:
        return const AuthFailure(
          code: 'unknown',
          message: 'Something went wrong. Please try again.',
        );
    }
  }
}