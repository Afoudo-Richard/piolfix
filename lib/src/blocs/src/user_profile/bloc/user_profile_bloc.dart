import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({required this.userBloc})
      : super(UserProfileState(
          firstName: userBloc.state.user?.firstname != null
              ? FirstName.dirty(userBloc.state.user!.firstname ?? 'N/A')
              : const FirstName.pure(),
          lastName: userBloc.state.user?.lastname != null
              ? LastName.dirty(userBloc.state.user!.lastname ?? 'N/A')
              : const LastName.pure(),
          email: userBloc.state.user?.email != null
              ? Email.dirty(userBloc.state.user!.email ?? 'N/A')
              : const Email.pure(),
          phone: userBloc.state.user?.phone != null
              ? Phone.dirty(userBloc.state.user!.phone ?? 'N/A')
              : const Phone.pure(),
        )) {
    on<UserProfileChanged>(_onUserProfileChanged);

    on<UserProfileFirstNameChanged>(_onUserProfileFirstNameChanged);
    on<UserProfileLastNameChanged>(_onUserProfileLastNameChanged);
    on<UserProfilePhoneChanged>(_onUserProfilePhoneChanged);
    on<UserProfileEmailChanged>(_onUserProfileEmailChanged);
    on<UserProfileInputsChecked>(_onUserProfileInputsChecked);
    on<UserProfileSubmitted>(_onUserProfileSubmitted);
  }

  final UserBloc userBloc;

  Future<void> _onUserProfileChanged(
    UserProfileChanged event,
    Emitter<UserProfileState> emit,
  ) async {}

  void _onUserProfileFirstNameChanged(
    UserProfileFirstNameChanged event,
    Emitter<UserProfileState> emit,
  ) {
    final firstname = FirstName.dirty(event.firstname);
    emit(state.copyWith(
      firstName: firstname,
      formStatus: Formz.validate([
        firstname,
        state.lastName,
        state.phone,
        state.email,
      ]),
    ));
  }

  void _onUserProfileLastNameChanged(
    UserProfileLastNameChanged event,
    Emitter<UserProfileState> emit,
  ) {
    final lastname = LastName.dirty(event.lastname);
    emit(state.copyWith(
      lastName: lastname,
      formStatus: Formz.validate([
        state.firstName,
        lastname,
        state.phone,
        state.email,
      ]),
    ));
  }

  void _onUserProfilePhoneChanged(
    UserProfilePhoneChanged event,
    Emitter<UserProfileState> emit,
  ) {
    final phone = Phone.dirty(event.phone);
    emit(state.copyWith(
      phone: phone,
      formStatus: Formz.validate([
        state.firstName,
        state.lastName,
        phone,
        state.email,
      ]),
    ));
  }

  void _onUserProfileEmailChanged(
    UserProfileEmailChanged event,
    Emitter<UserProfileState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(
      email: email,
      formStatus: Formz.validate([
        state.firstName,
        state.lastName,
        state.phone,
        email,
      ]),
    ));
  }

  Future<void> _onUserProfileInputsChecked(
    UserProfileInputsChecked event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        firstName: FirstName.dirty(state.firstName.value),
        lastName: LastName.dirty(state.lastName.value),
        email: Email.dirty(state.email.value),
        phone: Phone.dirty(state.phone.value),
      ),
    );
  }

  Future<void> _onUserProfileSubmitted(
    UserProfileSubmitted event,
    Emitter<UserProfileState> emit,
  ) async {
    if (state.formStatus.isValidated) {
      emit(
        state.copyWith(
          formStatus: FormzStatus.submissionInProgress,
        ),
      );

      try {
        User currentUser = await ParseUser.currentUser();
        final user = await _updateProfile(currentUser);
        userBloc.add(
          UserChanged(
            user: user,
          ),
        );
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
          ),
        );

        emit(
          state.copyWith(
            formStatus: FormzStatus.pure,
          ),
        );

        // try {
        //   User user = userBloc.state.user!;
        //   await _sendUserNotification(
        //       user.objectId!, "Your profile was updated you are now a tasker.");
        // } catch (e) {
        //   print("Errrrooooooooooorr @@@@@@@@@@@@@@##########");
        // }
      } on ErrorUpdatingUserProfile catch (e) {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            errorMessage: e.message,
          ),
        );
      } catch (e) {
        emit(state.copyWith(
          formStatus: FormzStatus.submissionFailure,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  Future<User> _updateProfile(User updateUser) async {
    var user = updateUser
      ..firstname = state.firstName.value
      ..lastname = state.lastName.value
      ..phone = state.phone.value;

    var response = await user.save();

    if (response.success) {
      return user;
    } else {
      throw ErrorUpdatingUserProfile(message: response.error?.message);
    }
  }
}
