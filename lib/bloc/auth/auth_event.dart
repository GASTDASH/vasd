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

class AuthSignOutEvent extends AuthEvent {
  AuthSignOutEvent({
    required this.userId,
  });

  final String userId;
}