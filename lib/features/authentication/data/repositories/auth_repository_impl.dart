import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_data_source.dart';
import '../../domain/errors/auth_failure.dart';
import '../errors/firebase_auth_error_mapper.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  // Convert Firebase User into our domain AppUser entity.
  AppUser _mapFirebaseUser(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      phoneNumber: user.phoneNumber,
      isEmailVerified: user.emailVerified,
      isAnonymous: user.isAnonymous,
    );
  }

  Future<T> _handleAuthErrors<T>(
      Future<T> Function() operation,
      ) async {
    try {
      return await operation();
    } on AuthFailure {
      rethrow;
    } on FirebaseAuthException catch (exception) {
      throw FirebaseAuthErrorMapper.map(exception);
    } on FirebaseException {
      throw const AuthFailure(
        code: 'service-error',
        message: 'A service error occurred. Please try again.',
      );
    } catch (_) {
      throw const AuthFailure(
        code: 'unknown',
        message: 'Something went wrong. Please try again.',
      );
    }
  }

  // Get currently authenticated user.
  @override
  AppUser? get currentUser {
    final user = _dataSource.currentUser;

    if (user == null) return null;

    return _mapFirebaseUser(user);
  }

  // Listen to authentication state changes.
  @override
  Stream<AppUser?> get authStateChanges {
    return _dataSource.authStateChanges.map(
          (user) => user == null ? null : _mapFirebaseUser(user),
    );
  }

  // Register with email and password.
  @override
  Future<AppUser> signUpWithEmail({
    required String email,
    required String password,
  }) async {

    return _handleAuthErrors(() async{
      final credential = await _dataSource.signUpWithEmail(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw StateError('Firebase returned no user after registration.');
      }

      return _mapFirebaseUser(user);
    });
  }

  // Sign in with email and password.
  @override
  Future<AppUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return _handleAuthErrors(() async{
      final credential = await _dataSource.signInWithEmail(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw StateError('Firebase returned no user after sign in.');
      }

      return _mapFirebaseUser(user);
    });
  }

  // Google sign-in will be implemented in a later step.
  @override
  Future<AppUser> signInWithGoogle() {
    throw UnimplementedError(
      'Google sign-in has not been implemented yet.',
    );
  }

  // Send email verification.
  @override
  Future<void> sendEmailVerification() {
    return _handleAuthErrors(() => _dataSource.sendEmailVerification());
  }

  // Send password reset email.
  @override
  Future<void> sendPasswordResetEmail({
    required String email,
  }) {
    return _handleAuthErrors(() => _dataSource.sendPasswordResetEmail(email: email));
  }

  // Sign out.
  @override
  Future<void> signOut() {
    return _handleAuthErrors(()=>_dataSource.signOut());
  }
}