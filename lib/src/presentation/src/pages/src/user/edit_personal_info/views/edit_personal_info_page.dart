import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class EditPersonalInfoPage extends StatelessWidget {
  const EditPersonalInfoPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const EditPersonalInfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Edit Profile',
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState) {
            return BlocBuilder<UserProfileBloc, UserProfileState>(
              builder: (context, state) {
                return Column(
                  children: [
                    1.h.ph,
                    CustomInput(
                      inputInitialValue: userState.user?.firstname,
                      label: 'First Name',
                      inputHintText: 'Enter your first name ',
                      backgroundColor: Colors.white.withOpacity(0.7),
                      labelTextStyle: const TextStyle(
                        color: primaryColor,
                      ),
                      inputErrorText: state.firstName.invalid
                          ? state.firstName.error
                          : null,
                      onChanged: (value) {
                        BlocProvider.of<UserProfileBloc>(context)
                            .add(UserProfileFirstNameChanged(value));
                      },
                    ),
                    2.h.ph,
                    CustomInput(
                      inputInitialValue: userState.user?.lastname,
                      label: 'Last Name',
                      inputHintText: 'Enter your last name ',
                      backgroundColor: Colors.white.withOpacity(0.7),
                      labelTextStyle: const TextStyle(
                        color: primaryColor,
                      ),
                      inputErrorText:
                          state.lastName.invalid ? state.lastName.error : null,
                      onChanged: (value) {
                        BlocProvider.of<UserProfileBloc>(context)
                            .add(UserProfileLastNameChanged(value));
                      },
                    ),
                    2.h.ph,
                    CustomInput(
                      inputInitialValue: userState.user?.phone,
                      label: 'Phone',
                      inputHintText: 'Enter your phone number ',
                      backgroundColor: Colors.white.withOpacity(0.7),
                      labelTextStyle: const TextStyle(
                        color: primaryColor,
                      ),
                      inputErrorText:
                          state.phone.invalid ? state.phone.error : null,
                      onChanged: (value) {
                        BlocProvider.of<UserProfileBloc>(context)
                            .add(UserProfilePhoneChanged(value));
                      },
                    ),
                    2.h.ph,
                    CustomInput(
                      inputEnabled: false,
                      inputInitialValue: userState.user?.email,
                      label: 'Email',
                      inputHintText: 'Enter your Email ',
                      backgroundColor: Colors.grey.withOpacity(0.7),
                      labelTextStyle: const TextStyle(
                        color: primaryColor,
                      ),
                      inputErrorText:
                          state.email.invalid ? state.email.error : null,
                      onChanged: (value) {
                        BlocProvider.of<UserProfileBloc>(context)
                            .add(UserProfileEmailChanged(value));
                      },
                    ),
                    3.h.ph,
                    SizedBox(
                      width: 100.w,
                      child: CustomButton(
                        backgroundColor: state.formStatus.isSubmissionInProgress
                            ? Colors.grey
                            : null,
                        onPressed: () {
                          state.formStatus.isValidated
                              ? state.formStatus.isSubmissionInProgress
                                  ? null
                                  : context
                                      .read<UserProfileBloc>()
                                      .add(UserProfileSubmitted())
                              : BlocProvider.of<UserProfileBloc>(context)
                                  .add(UserProfileInputsChecked());
                        },
                        child: state.formStatus.isSubmissionInProgress
                            ? LoadingIndicator(
                                color: secondaryColor,
                              )
                            : Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  letterSpacing: 1.5,
                                ),
                              ),
                      ),
                    ),
                    6.h.ph,
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
