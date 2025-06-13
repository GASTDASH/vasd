import 'dart:typed_data';

import 'package:vasd/repositories/auth/models/user.dart';

abstract class AuthInterface {
  User? user;

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

  Future<User?> getUser();

  Future<dynamic> uploadPhoto(Uint8List imageBytes);

  Future<void> signInWithOtp({
    required String email,
  });

  Future<void> verifyOtp({
    required String otp,
    required String email,
  });

  Future<void> changeUserInfo({
    required String username,
    required String phone,
  });

  Future<bool> hasPermission(String userId);

  Future<void> updatePassword(String newPassword);
}
