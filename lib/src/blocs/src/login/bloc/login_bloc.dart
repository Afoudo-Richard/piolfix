import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    on<LoginWithGoogle>(_onLoginWithGoogle);

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
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        final response = await _login(
          email: state.email.value,
          password: state.password.value,
        );

        User user = await ParseUser.currentUser();

        print(user);

        final fcmToken = await FirebaseMessaging.instance.getToken();

        if (user.devices!
                .where((element) => element == fcmToken)
                .toList()
                .isEmpty &&
            fcmToken != null &&
            user.devices != null) {
          /// Device is empty create a new remote device

          final deviceName = await DeviceHelper.platformName();
          String firebaseCMToken = fcmToken;

          /// update user devices with new device
          // user.("devices", [firebaseCMToken]);
          user.devices = List.of(user.devices!)..add(firebaseCMToken);
          final userUpdateResponse = await user.save();
          print(userUpdateResponse);
        }

        authenticationBloc.add(
          const AuthenticationChanged(
            authenticated: true,
          ),
        );
        userBloc.add(UserChanged(user: user));

        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } on ErrorLoggingIn catch (e) {
        emit(state.copyWith(
            errorMessage: e.getErrorsAsString ?? e.message,
            status: FormzStatus.submissionFailure));
      } catch (e) {
        emit(state.copyWith(
          status: FormzStatus.submissionFailure,
        ));
      }
    }
  }

  void _onLoginWithGoogle(
    LoginWithGoogle event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginWithGoogle();

      User user = await ParseUser.currentUser();

      print(user);

      final fcmToken = await FirebaseMessaging.instance.getToken();

      if (user.devices!
              .where((element) => element == fcmToken)
              .toList()
              .isEmpty &&
          fcmToken != null &&
          user.devices != null) {
        /// Device is empty create a new remote device

        final deviceName = await DeviceHelper.platformName();
        String firebaseCMToken = fcmToken;

        /// update user devices with new device
        // user.("devices", [firebaseCMToken]);
        user.devices = List.of(user.devices!)..add(firebaseCMToken);
        final userUpdateResponse = await user.save();
        print(userUpdateResponse);
      }

      authenticationBloc.add(
        const AuthenticationChanged(
          authenticated: true,
        ),
      );
      userBloc.add(UserChanged(user: user));

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on ErrorLoggingIn catch (e) {
      emit(state.copyWith(
          errorMessage: e.getErrorsAsString ?? e.message,
          status: FormzStatus.submissionFailure));
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }

  Future _login({
    required String email,
    required String password,
  }) async {
    final user = ParseUser(email, password, email);

    var response = await user.login();
    if (response.success) {
      var result = response.result;
      return result;
    } else {
      print(response.error?.exception.toString());

      throw ErrorLoggingIn(
        message: response.error?.message == 'Invalid username/password.'
            ? 'Invalid Email or Password.'
            : response.error?.message,
      );
    }
  }

  Future _loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ]);

    GoogleSignInAccount? account = await googleSignIn.signIn();

    GoogleSignInAuthentication authentication = await account!.authentication;

    // final credential = GoogleSign

    final user = await ParseUser.loginWith(
      'google',
      google(
        authentication.accessToken!,
        googleSignIn.currentUser!.id,
        authentication.idToken!,
      ),
    );

    print(user);
  }
}
