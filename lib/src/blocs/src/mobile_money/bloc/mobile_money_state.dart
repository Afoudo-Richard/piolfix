// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'mobile_money_bloc.dart';

class MobileMoneyState extends Equatable {
  final Phone phone;
  final FormzStatus formStatus;
  final String? errorMessage;

  MobileMoneyState({
    this.phone = const Phone.pure(),
    this.formStatus = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [phone, formStatus, errorMessage];

  MobileMoneyState copyWith({
    Phone? phone,
    FormzStatus? formStatus,
    String? errorMessage,
  }) {
    return MobileMoneyState(
      phone: phone ?? this.phone,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
