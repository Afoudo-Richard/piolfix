import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'mobile_money_event.dart';
part 'mobile_money_state.dart';

class MobileMoneyBloc extends Bloc<MobileMoneyEvent, MobileMoneyState> {
  final CamPayApi camPayApi;

  MobileMoneyBloc({required this.camPayApi}) : super(MobileMoneyState()) {
    on<MobileMoneyPhoneChanged>(_onMobileMoneyPhoneChanged);
    on<SubmitMobileMoneyInputsChecked>(_onSubmitMobileMoneyInputsChecked);
    on<MobileMoneySubmitted>(_onMobileMoneySubmitted);
  }

  Future<void> _onMobileMoneyPhoneChanged(
    MobileMoneyPhoneChanged event,
    Emitter<MobileMoneyState> emit,
  ) async {
    final phone = Phone.dirty(event.value);
    emit(state.copyWith(
      phone: phone,
      formStatus: Formz.validate([
        phone,
      ]),
    ));
  }

  void _onSubmitMobileMoneyInputsChecked(
    SubmitMobileMoneyInputsChecked event,
    Emitter<MobileMoneyState> emit,
  ) async {
    emit(
      state.copyWith(
        phone: Phone.dirty(state.phone.value),
      ),
    );
  }

  void _onMobileMoneySubmitted(
    MobileMoneySubmitted event,
    Emitter<MobileMoneyState> emit,
  ) async {
    if (state.formStatus.isValidated) {
      emit(
        state.copyWith(
          formStatus: FormzStatus.submissionInProgress,
        ),
      );

      try {
        final response = await camPayApi.requestPayment(
          amount: '100',
          phone: state.phone.value,
        );

        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
          ),
        );
      } catch (e) {
        print(e);
      }
    }
  }
}
