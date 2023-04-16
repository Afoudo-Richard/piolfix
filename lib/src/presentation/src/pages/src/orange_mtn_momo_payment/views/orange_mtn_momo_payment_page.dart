import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class OrangeMtnMomoPaymentPage extends StatelessWidget {
  const OrangeMtnMomoPaymentPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const OrangeMtnMomoPaymentPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "ORANGE/MTN MOMO",
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.h.ph,
            Text(
              'Amount: FCFA 2000',
              style: TextStyle(
                color: secondaryColor,
                fontSize: 16.sp,
                letterSpacing: 1.5,
              ),
            ),
            3.h.ph,
            BlocBuilder<MobileMoneyBloc, MobileMoneyState>(
              builder: (context, state) {
                return CustomInput(
                  label: 'Enter phone number',
                  inputHintText: 'E.g. 672367020 or 693386383',
                  backgroundColor: Colors.white.withOpacity(0.7),
                  labelTextStyle: const TextStyle(
                    color: primaryColor,
                  ),
                  onChanged: (value) {
                    BlocProvider.of<MobileMoneyBloc>(context)
                        .add(MobileMoneyPhoneChanged(value: value));
                  },
                  inputErrorText:
                      state.phone.invalid ? state.phone.error : null,
                );
              },
            ),
            4.h.ph,
            BlocBuilder<MobileMoneyBloc, MobileMoneyState>(
              builder: (context, state) {
                return state.formStatus.isSubmissionSuccess
                    ? Text(
                        'Request sent. Dial *126 or #150# and confirm.',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: 12.sp,
                          letterSpacing: 1.5,
                        ),
                      )
                    : const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<MobileMoneyBloc, MobileMoneyState>(
        builder: (context, state) {
          return !state.formStatus.isSubmissionSuccess
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IntrinsicHeight(
                    child: SizedBox(
                        width: 100.w,
                        child: CustomButton(
                            backgroundColor:
                                state.formStatus.isSubmissionInProgress
                                    ? Colors.grey
                                    : null,
                            onPressed: () {
                              state.formStatus.isValidated
                                  ? state.formStatus.isSubmissionInProgress
                                      ? null
                                      : context
                                          .read<MobileMoneyBloc>()
                                          .add(MobileMoneySubmitted())
                                  : BlocProvider.of<MobileMoneyBloc>(context)
                                      .add(SubmitMobileMoneyInputsChecked());
                            },
                            child: state.formStatus.isSubmissionInProgress
                                ? LoadingIndicator(
                                    color: secondaryColor,
                                  )
                                : Text(
                                    'Pay',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      letterSpacing: 1.5,
                                    ),
                                  ))),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
