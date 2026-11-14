import '../entities/app_user.dart';
import '../repositories/auth_repository.dart';

class GetAuthState {
  final AuthRepository _repository;

  const GetAuthState(this._repository);

  Stream<AppUser?> call() {
    return _repository.authStateChanges;
  }
}