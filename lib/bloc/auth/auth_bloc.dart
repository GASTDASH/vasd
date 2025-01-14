import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/repositories/auth/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthInterface authRepo;

  AuthBloc({required this.authRepo}) : super(AuthUnauthorizedState()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await authRepo.loginWithEmailPassword(
          email: event.email,
          password: event.password,
        );

        await authRepo.getUser();

        emit(AuthAuthorizedState());
      } catch (e) {
        emit(AuthUnauthorizedState(error: e));
      }
    });
    on<AuthLoginSavedEvent>((event, emit) async {
      await authRepo.getUser();

      emit(AuthAuthorizedState());
    });
    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await authRepo.signUpWithEmailPassword(
          name: event.name,
          email: event.email,
          phone: event.phone,
          password: event.password,
        );

        emit(AuthSignedUpState());
      } catch (e) {
        emit(AuthUnauthorizedState(error: e));
      }
    });
    on<AuthSignOutEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await authRepo.logout();

        emit(AuthUnauthorizedState());
      } catch (e) {
        emit(AuthAuthorizedState(error: e));
      }
    });
    on<AuthUploadPhotoEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await authRepo.uploadPhoto(event.imageBytes);

        await authRepo.getUser();

        emit(AuthAuthorizedState());
      } catch (e) {
        emit(AuthAuthorizedState(error: e));
      }
    });
  }
}
