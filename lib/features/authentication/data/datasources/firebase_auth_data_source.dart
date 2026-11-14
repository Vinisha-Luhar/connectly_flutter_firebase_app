import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  // Current authenticated Firebase user
  User? get currentUser => _firebaseAuth.currentUser;

  // Listen to authentication state changes
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Register using email and password
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign in using email and password
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Send email verification
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw StateError('No authenticated user found.');
    }

    await user.sendEmailVerification();
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail({
    required String email,
  }) {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Sign out
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  // Reload the current user's Firebase profile
  Future<User?> reloadCurrentUser() async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      return null;
    }

    await user.reload();

    return _firebaseAuth.currentUser;
  }
}