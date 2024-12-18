abstract class AuthInterface {
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<void> logout();
}
