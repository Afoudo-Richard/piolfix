import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poilfix/poilfix.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        userBloc: BlocProvider.of<UserBloc>(context),
      ),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Logged in Successfully"),
                ),
              );
          } else if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Failed to login user'),
                ),
              );
          }
        },
        child: CustomScaffold(
            body: SafeArea(
          child: SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                2.h.ph,
                Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1.h.ph,
                    // Text(
                    //   trans(context)!.welcome_back,
                    //   style: TextStyle(
                    //     fontSize: 16.sp,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/piolfix_logo_text.png",
                          width: 30.w,
                        ),
                      ],
                    ),
                    6.h.ph,
                    // Text(
                    //   trans(context)!.sign_in_to_your_piolfix_account,
                    //   style: TextStyle(
                    //     fontSize: 12.sp,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Hello !",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 22.sp,
                                ),
                              ),
                              Text(
                                "Welcome !",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 22.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          "assets/images/welcome_5.png",
                          width: 35.w,
                        ),
                      ],
                    ),
                    2.h.ph,
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return CustomInput(
                          // label: trans(context)!.email,
                          inputHintText: trans(context)!.enter_email_address,
                          backgroundColor: Colors.white.withOpacity(0.7),
                          labelTextStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          onChanged: (email) =>
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginEmailChanged(email)),
                          inputErrorText:
                              state.email.invalid ? state.email.error : null,
                        );
                      },
                    ),
                    2.h.ph,
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return CustomInput(
                          // label: trans(context)!.password,
                          inputObscureText: hidePassword,
                          inputHintText: trans(context)!.enter_account_password,
                          backgroundColor: Colors.white.withOpacity(0.7),
                          labelTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            child: Icon(
                              hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 18.sp,
                            ),
                          ),
                          onChanged: (value) =>
                              BlocProvider.of<LoginBloc>(context)
                                  .add(LoginPasswordChanged(value)),
                          inputErrorText: state.password.invalid
                              ? state.password.error
                              : null,
                        );
                      },
                    ),
                    1.h.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    3.h.ph,
                    SizedBox(
                      width: 100.w,
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return CustomButton(
                            backgroundColor: state.status.isSubmissionInProgress
                                ? Colors.grey
                                : null,
                            onPressed: () {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                const AuthenticationHasWalkedThroughChanged(
                                    hasWalkedThrough: false),
                              );

                              // main login

                              // state.status.isValidated
                              //     ? state.status.isSubmissionInProgress
                              //         ? null
                              //         : context
                              //             .read<LoginBloc>()
                              //             .add(LoginSubmitted())
                              //     : BlocProvider.of<LoginBloc>(context)
                              //         .add(SubmitLoginInputsChecked());
                            },
                            child: state.status.isSubmissionInProgress
                                ? LoadingIndicator(
                                    color: secondaryColor,
                                  )
                                : Text(
                                    'Sign In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                    2.h.ph,
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                        2.w.pw,
                        Text(
                          "Or",
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                        2.w.pw,
                        Expanded(
                          child: Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    2.h.ph,
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            print("sign in wiht google");
                            context.read<LoginBloc>().add(LoginWithGoogle());
                          },
                          child: CustomContainer(
                            boxShadow: [],
                            padding: EdgeInsets.symmetric(
                              vertical: 12.sp,
                            ),
                            border: Border.all(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/logos_google-icon.svg',
                                  height: 15.sp,
                                  width: 15.sp,
                                ),
                                2.w.pw,
                                const Text("Sign In with Google"),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // 2.h.ph,
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: CustomButton(
                    //     backgroundColor: Colors.white,
                    //     border: const BorderSide(color: primaryColor),
                    //     child: Text(
                    //       trans(context)!.continue_anonymously,
                    //       style: TextStyle(
                    //         color: primaryColor,
                    //         fontSize: 12.sp,
                    //       ),
                    //     ),
                    //     onPressed: () {
                    //       BlocProvider.of<AuthenticationBloc>(context).add(
                    //         AuthenticationSignInAnonymous(),
                    //       );
                    //     },
                    //   ),
                    // ),
                    5.h.ph,
                    ListRowText(
                      leadingText: trans(context)!.new_to_piolfix,
                      trailingText: " " + trans(context)!.sign_up,
                      onTapTrailingText: () {
                        Navigator.pushReplacement(
                          context,
                          RegistrationPage.route(),
                        );
                      },
                    ),
                    5.h.ph,
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
