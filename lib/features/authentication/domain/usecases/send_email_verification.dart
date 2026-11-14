import '../repositories/auth_repository.dart';

class SendEmailVerification {
  final AuthRepository _repository;

  const SendEmailVerification(this._repository);

  Future<void> call() {
    return _repository.sendEmailVerification();
  }
}