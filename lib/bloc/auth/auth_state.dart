part of 'auth_bloc.dart';

sealed class AuthState {
  AuthState({
    this.error,
  });

  final Object? error;
}

final class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthUnauthorizedState extends AuthState {
  AuthUnauthorizedState({
    super.error,
  });
}

class AuthSignedUpState extends AuthUnauthorizedState {
  AuthSignedUpState({
    super.error,
  });
}

class AuthAuthorizedState extends AuthState {
  AuthAuthorizedState({
    super.error,
  });
}

class AuthOtpVerificationState extends AuthUnauthorizedState {
  AuthOtpVerificationState({
    super.error,
  });
}

class AuthChangingUserInfoState extends AuthLoadingState {
  AuthChangingUserInfoState();
}

class AuthChangedUserInfoState extends AuthAuthorizedState {
  AuthChangedUserInfoState({
    super.error,
  });
}
