import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TaskDetailPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return CustomScaffold(
          appBar: CustomAppBar(
            title: trans(context)!.task_details,
          ),
          body: SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                2.h.ph,
                BlocBuilder<SelectTaskBloc, SelectTaskState>(
                  builder: (context, state) {
                    return CustomInput(
                      inputMaxLines: 9,
                      label: trans(context)!.task_details,
                      inputHintText: trans(context)!.for_example_what_supplies,
                      backgroundColor: Colors.white.withOpacity(0.7),
                      labelTextStyle: const TextStyle(
                        color: primaryColor,
                      ),
                      onChanged: (value) {
                        BlocProvider.of<SelectTaskBloc>(context)
                            .add(SelectTaskTaskDetailsChanged(value));
                      },
                      inputErrorText: state.taskDetails.invalid
                          ? state.taskDetails.error
                          : null,
                    );
                  },
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IntrinsicHeight(
              child: SizedBox(
                width: 100.w,
                child: BlocBuilder<SelectTaskBloc, SelectTaskState>(
                  builder: (context, state) {
                    return CustomButton(
                      // backgroundColor: state.formStatus.isSubmissionInProgress
                      //       ? Colors.grey
                      //       : null,
                      onPressed: () {
                        state.formStatus.isValidated
                            ? state.formStatus.isSubmissionInProgress
                                ? null
                                : Navigator.push(
                                    context, TaskReviewPage.route())
                            : BlocProvider.of<SelectTaskBloc>(context)
                                .add(SelectTaskTaskDetailsInputsChecked());
                      },
                      child: state.formStatus.isSubmissionInProgress
                          ? LoadingIndicator(
                              color: secondaryColor,
                            )
                          : Text(
                              trans(context)!.next,
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
        );
      },
    );
  }
}
