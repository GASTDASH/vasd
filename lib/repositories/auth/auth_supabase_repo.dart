import 'package:supabase_flutter/supabase_flutter.dart';

import './auth_interface.dart';

class AuthSupabaseRepo implements AuthInterface {
  AuthSupabaseRepo(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Future<String> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    final AuthResponse res = await supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (res.user == null) {
      throw const AuthException("User is null!");
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
    final AuthResponse res = await supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {
        "name": name,
        "phone": phone,
      },
    );

    if (res.user == null) {
      throw const AuthException("User is null");
    }

    // await loginWithEmailPassword(email: email, password: password);

    // await supabaseClient.from("users").insert({"name": name, "phone": phone});

    return res.user!.id;
  }

  @override
  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }
}
