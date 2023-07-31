import 'package:bloc/bloc.dart';
import 'package:mypfe/businessLogic/bloc/auth/auth_event.dart';
import 'package:mypfe/businessLogic/bloc/auth/auth_state.dart';
import 'package:mypfe/services/auth/auth_provider.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialise(isLoading: true)) {
    //Initialize
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialise();
      final user = provider.currentUser;

      if (user == null) {
        emit(const AuthStateLogOut(
          exception: null,
          isLoading: false,
        ));
      } else if (!user.isEmailVerified) {
        emit(const AuthStateNeedVerification(isLoading: false));
      } else {
        emit(AuthStateLoggedIn(
          user: user,
          isLoading: false,
        ));
      }
    });

    //Login
    on<AuthEventLogin>(
      (event, emit) async {
        emit(const AuthStateLoading(
          exception: null,
          isLoading: true,
          loadingText: 'Veuillez patienter nous vous connectons',
        ));
        try {
          final email = event.email;
          final password = event.password;
          await provider.logIn(
            email: email,
            password: password,
          );
        } on Exception catch (e) {
          emit(AuthStateLoading(
            exception: e,
            isLoading: false,
          ));
        }
      },
    );
  }
}
