import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';
import 'package:poilfix/src/blocs/src/tasker_profile_info/bloc/tasker_profile_info_bloc.dart';

class TaskerProfileInfoPage extends StatelessWidget {
  const TaskerProfileInfoPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const TaskerProfileInfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'My Tasker Info',
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          return SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              children: [
                3.h.ph,
                BlocBuilder<TaskerProfileInfoBloc, TaskerProfileInfoState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        1.h.ph,
                        CustomInput(
                          inputInitialValue: userState.user?.tools,
                          inputMaxLines: 5,
                          label: 'Tools',
                          inputHintText: 'Enter your tools used',
                          backgroundColor: Colors.white.withOpacity(0.7),
                          labelTextStyle: const TextStyle(
                            color: primaryColor,
                          ),
                          inputErrorText: state.taskerTool.invalid
                              ? state.taskerTool.error
                              : null,
                          onChanged: (value) {
                            BlocProvider.of<TaskerProfileInfoBloc>(context)
                                .add(TaskerProfileInfoToolChanged(value));
                          },
                        ),
                        3.h.ph,
                        CustomInput(
                          inputInitialValue: userState.user?.skills,
                          inputMaxLines: 5,
                          label: 'Skills and Experience',
                          inputHintText: 'Enter your Skills and Experiences ',
                          backgroundColor: Colors.white.withOpacity(0.7),
                          labelTextStyle: const TextStyle(
                            color: primaryColor,
                          ),
                          inputErrorText: state.taskerSkill.invalid
                              ? state.taskerSkill.error
                              : null,
                          onChanged: (value) {
                            BlocProvider.of<TaskerProfileInfoBloc>(context)
                                .add(TaskerProfileInfoSkillChanged(value));
                          },
                        ),
                        3.h.ph,
                        CustomInput(
                          inputInitialValue: userState.user?.pricePerHr,
                          label: 'Price Per Hour (FCFA)',
                          inputHintText: 'Enter your price per hour ',
                          backgroundColor: Colors.white.withOpacity(0.7),
                          labelTextStyle: const TextStyle(
                            color: primaryColor,
                          ),
                          inputErrorText: state.taskerPricePerHr.invalid
                              ? state.taskerPricePerHr.error
                              : null,
                          onChanged: (value) {
                            BlocProvider.of<TaskerProfileInfoBloc>(context)
                                .add(TaskerProfileInfoPricePerHrChanged(value));
                          },
                        ),
                        6.h.ph,
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              spreadRadius: 0,
              offset: Offset(0, -8),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: SizedBox(
              width: 100.w,
              child: BlocBuilder<TaskerProfileInfoBloc, TaskerProfileInfoState>(
                builder: (context, state) {
                  return CustomButton(
                    backgroundColor: state.formStatus.isSubmissionInProgress
                        ? Colors.grey
                        : null,
                    onPressed: () {
                      state.formStatus.isValidated
                          ? state.formStatus.isSubmissionInProgress
                              ? null
                              : context
                                  .read<TaskerProfileInfoBloc>()
                                  .add(TaskerProfileInfoSubmitted())
                          : BlocProvider.of<TaskerProfileInfoBloc>(context)
                              .add(TaskerProfileInfoInputsChecked());
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
