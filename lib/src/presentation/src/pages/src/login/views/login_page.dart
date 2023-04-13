import 'dart:ui';

import 'package:flutter/material.dart';
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
                  content: Text("User Logged in Successfully"),
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
          child: Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    tileMode: TileMode.decal,
                    colors: [
                      primaryColor,
                      Colors.white,
                    ],
                  ),
                  // image: DecorationImage(
                  //   image: AssetImage("assets/images/others/car_bg.jpg"),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: SingleChildScrollView(
                  padding: pagePadding,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      3.h.ph,
                      CustomContainer(
                        backgroundColor: Colors.transparent,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              3.h.ph,
                              Text(
                                'Welcome Back To',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/logo_trans.png",
                                    width: 30.w,
                                  ),
                                ],
                              ),
                              4.h.ph,
                              Text(
                                'Sign in to your PiolFix account',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                              2.h.ph,
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  return CustomInput(
                                    label: trans(context)!.email,
                                    inputHintText:
                                        trans(context)!.enter_email_address,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.7),
                                    labelTextStyle: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    onChanged: (email) =>
                                        BlocProvider.of<LoginBloc>(context)
                                            .add(LoginEmailChanged(email)),
                                    inputErrorText: state.email.invalid
                                        ? state.email.error
                                        : null,
                                  );
                                },
                              ),
                              2.h.ph,
                              BlocBuilder<LoginBloc, LoginState>(
                                builder: (context, state) {
                                  return CustomInput(
                                    label: trans(context)!.password,
                                    inputObscureText: hidePassword,
                                    inputHintText:
                                        trans(context)!.enter_account_password,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.7),
                                    labelTextStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                    trailing: GestureDetector(
                                      onTap: () {
                                        print(hidePassword);
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
                              3.h.ph,
                              SizedBox(
                                width: 100.w,
                                child: BlocBuilder<LoginBloc, LoginState>(
                                  builder: (context, state) {
                                    return CustomButton(
                                      onPressed: () {
                                        state.status.isValidated
                                            ? context
                                                .read<LoginBloc>()
                                                .add(LoginSubmitted())
                                            : BlocProvider.of<LoginBloc>(
                                                    context)
                                                .add(
                                                    SubmitLoginInputsChecked());
                                      },
                                      child: state.status.isSubmissionInProgress
                                          ? LoadingIndicator(
                                              color: secondaryColor,
                                            )
                                          : Text(
                                              trans(context)!.login,
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
                              SizedBox(
                                width: double.infinity,
                                child: CustomButton(
                                  backgroundColor: Colors.white,
                                  border: const BorderSide(color: primaryColor),
                                  child: Text(
                                    'Browse incognito',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<AuthenticationBloc>(context)
                                        .add(
                                      AuthenticationSignInAnonymous(),
                                    );
                                  },
                                ),
                              ),
                              5.h.ph,
                              ListRowText(
                                leadingText: 'New to PiolFix?',
                                trailingText: " " + trans(context)!.sign_up,
                                onTapTrailingText: () {
                                  Navigator.pushReplacement(
                                    context,
                                    RegistrationPage.route(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 3.sp,
              //   right: 3.sp,
              //   child: GestureDetector(
              //     onTap: () {
              //       showModalBottomSheet(
              //         barrierColor: primaryColor.withOpacity(0.6),
              //         isScrollControlled: true,
              //         context: context,
              //         builder: (ctx) {
              //           return const AllLanguages();
              //         },
              //       );
              //     },
              //     child: CustomContainer(
              //       child: Text(
              //           " ${trans(context)!.language}: ${context.locale.languageCode}"),
              //     ),
              //   ),
              // ),
            ],
          ),
        )),
      ),
    );
  }
}
