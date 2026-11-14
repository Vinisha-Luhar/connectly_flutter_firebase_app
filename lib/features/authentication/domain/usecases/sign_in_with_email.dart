import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail {
  final AuthRepository _repository;

  const SignInWithEmail(this._repository);

  Future<AppUser> call({
    required String email,
    required String password,
  }) {
    return _repository.signInWithEmail(
      email: email,
      password: password,
    );
  }
}