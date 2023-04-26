part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();
  @override
  List<Object> get props => [];
}

class UserProfileChanged extends UserProfileEvent {}

class UserProfileFirstNameChanged extends UserProfileEvent {
  const UserProfileFirstNameChanged(this.firstname);

  final String firstname;

  @override
  List<Object> get props => [firstname];
}

class UserProfileLastNameChanged extends UserProfileEvent {
  const UserProfileLastNameChanged(this.lastname);

  final String lastname;

  @override
  List<Object> get props => [lastname];
}

class UserProfilePhoneChanged extends UserProfileEvent {
  const UserProfilePhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

class UserProfileEmailChanged extends UserProfileEvent {
  const UserProfileEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class UserProfileInputsChecked extends UserProfileEvent {}

class UserProfileSubmitted extends UserProfileEvent {}
