import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.authenticationBloc,
    required this.userBloc,
  }) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<SubmitLoginInputsChecked>(_onSubmitLoginInputsChecked);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationBloc authenticationBloc;
  final UserBloc userBloc;

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([state.password, email]),
    ));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = LoginPassword.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    ));
  }

  void _onSubmitLoginInputsChecked(
    SubmitLoginInputsChecked event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      email: Email.dirty(state.email.value),
      password: LoginPassword.dirty(state.password.value),
    ));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {}

  Future _login({
    required String email,
    required String password,
  }) async {}
}
