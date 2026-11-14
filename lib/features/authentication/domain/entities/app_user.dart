
class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String? phoneNumber;
  final bool isEmailVerified;
  final bool isAnonymous;

  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.phoneNumber,
    this.isEmailVerified = false,
    this.isAnonymous = false,
  });
}
