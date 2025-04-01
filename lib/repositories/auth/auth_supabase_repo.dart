import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vasd/repositories/auth/models/user.dart';

import './auth_interface.dart';

class AuthSupabaseRepo implements AuthInterface {
  AuthSupabaseRepo(this.supabaseClient);

  @override
  User? user;
  final supabase.SupabaseClient supabaseClient;

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final supabase.AuthResponse res =
        await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (res.user == null) {
      throw const supabase.AuthException("User is null!");
    }

    return res.user!.id;
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final supabase.AuthResponse res = await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {
        "name": name,
        "phone": phone,
      },
    );

    if (res.user == null) {
      throw const supabase.AuthException("User is null");
    }

    // await loginWithEmailPassword(email: email, password: password);

    // await supabaseClient.from("users").insert({"name": name, "phone": phone});

    return res.user!.id;
  }

  @override
  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }

  @override
  Future<String> uploadPhoto(Uint8List imageBytes) async {
    final userId = user?.id;
    if (userId == null) throw Exception("User is null");

    final imagePath = "/$userId/avatar";
    await supabaseClient.storage.from("avatars").uploadBinary(
          imagePath,
          imageBytes,
          fileOptions: const supabase.FileOptions(upsert: true),
        );

    return supabaseClient.storage.from("avatars").getPublicUrl(imagePath);
  }

  @override
  Future<User?> getUser() async {
    var user = (await supabaseClient.auth.getUser()).user;
    if (user != null) {
      return this.user = User(
        id: user.id,
        email: user.email,
        name: user.userMetadata?["name"],
        phone: user.userMetadata?["phone"],
        photoUrl: supabaseClient.storage
            .from("avatars")
            .getPublicUrl("/${user.id}/avatar"),
      );
    }

    return null;
  }

  @override
  Future<void> signInWithOtp({
    required String email,
  }) async {
    await supabaseClient.auth.signInWithOtp(
      email: email,
      shouldCreateUser: false,
    );
  }

  @override
  Future<void> verifyOtp({
    required String otp,
    required String email,
  }) async {
    GetIt.I<Talker>().debug("otp = $otp\nemail = $email");
    await supabaseClient.auth.verifyOTP(
      type: supabase.OtpType.email,
      token: otp,
      email: email,
    );
  }
}
