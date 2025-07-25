part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  AuthLoginEvent({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class AuthLoginSavedEvent extends AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  final String email;
  final String password;
  final String name;
  final String phone;
}

class AuthSignOutEvent extends AuthEvent {}

class AuthUploadPhotoEvent extends AuthEvent {
  AuthUploadPhotoEvent({
    required this.imageBytes,
  });

  final Uint8List imageBytes;
}

class AuthSignInWithOtp extends AuthEvent {
  AuthSignInWithOtp({
    required this.email,
  });

  final String email;
}

class AuthVerifyOtp extends AuthEvent {
  AuthVerifyOtp({
    required this.otp,
    required this.email,
  });

  final String otp;
  final String email;
}

class AuthChangeUserInfo extends AuthEvent {
  AuthChangeUserInfo({
    required this.username,
    required this.phone,
  });

  final String username;
  final String phone;
}

class AuthUpdatePassword extends AuthEvent {
  AuthUpdatePassword({
    required this.newPassword,
  });

  final String newPassword;
}
