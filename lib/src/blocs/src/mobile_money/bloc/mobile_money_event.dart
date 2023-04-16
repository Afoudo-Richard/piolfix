part of 'mobile_money_bloc.dart';

abstract class MobileMoneyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MobileMoneySubmitted extends MobileMoneyEvent {}

class MobileMoneyPhoneChanged extends MobileMoneyEvent {
  final String value;
  MobileMoneyPhoneChanged({required this.value});
}

class SubmitMobileMoneyInputsChecked extends MobileMoneyEvent {}
