import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vasd/repositories/auth/auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthInterface authRepo;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        String userId = await authRepo.loginWithEmailPassword(
          email: event.email,
          password: event.password,
        );

        emit(AuthAuthorizedState(userId: userId));
      } catch (e) {
        emit(AuthErrorState(error: e));
      }
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
        emit(AuthErrorState(error: e));
      }
    });
    on<AuthSignOutEvent>((event, emit) async {
      emit(AuthLoadingState());

      try {
        await authRepo.logout();

        emit(AuthUnauthorizedState());
      } catch (e) {
        emit(AuthAuthorizedState(userId: event.userId));
      }
    });
  }
}
