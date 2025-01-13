import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:vasd/repositories/auth/models/user.dart';

import './auth_interface.dart';

class AuthSupabaseRepo implements AuthInterface {
  AuthSupabaseRepo(this.supabaseClient);

  final supabase.SupabaseClient supabaseClient;
  @override
  User? user;

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

    await getUser();

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

  //TODO: наверное надо перенести в интерфейс
  Future<User?> getUser() async {
    var user = (await supabaseClient.auth.getUser()).user;
    if (user != null) {
      return this.user = User(
        id: user.id,
        email: user.email,
        name: user.userMetadata?["name"],
        phone: user.userMetadata?["phone"],
        photoUrl: user.userMetadata?["photoUrl"],
      );
    }

    return null;
  }
}
