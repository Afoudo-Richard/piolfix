part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  final FirstName firstName;
  final LastName lastName;
  final Phone phone;
  final Email email;
  final FormzStatus formStatus;
  final String? errorMessage;

  const UserProfileState({
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.phone = const Phone.pure(),
    this.email = const Email.pure(),
    this.formStatus = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      firstName,
      lastName,
      phone,
      email,
      formStatus,
      errorMessage,
    ];
  }

  UserProfileState copyWith({
    FirstName? firstName,
    LastName? lastName,
    Phone? phone,
    Email? email,
    FormzStatus? formStatus,
    String? errorMessage,
  }) {
    return UserProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
