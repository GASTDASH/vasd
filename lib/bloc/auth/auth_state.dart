part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthUnauthorizedState extends AuthState {}

class AuthSignedUpState extends AuthUnauthorizedState {}

class AuthAuthorizedState extends AuthState {
  AuthAuthorizedState({
    required this.userId,
  });

  final String userId;
}

class AuthErrorState extends AuthUnauthorizedState {
  AuthErrorState({
    required this.error,
  });

  final Object error;
}
