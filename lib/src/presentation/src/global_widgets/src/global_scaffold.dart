import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';
import 'package:poilfix/src/blocs/src/tasker_profile_info/bloc/tasker_profile_info_bloc.dart';

class GlobalScaffold extends StatelessWidget {
  const GlobalScaffold({Key? key, required this.child}) : super(key: key);

  final Widget child;

  singleScaffoldMessenger(
    context, {
    Color backgroundColor = Colors.grey,
    required String message,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          content: Text(message),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<CategoryAddBloc, CategoryAddState>(
            listener: (context, state) {
              if (state.formStatus.isSubmissionSuccess) {
                singleScaffoldMessenger(
                  context,
                  message: 'Category Added Successfully',
                  backgroundColor: Colors.green,
                );
              } else if (state.formStatus.isSubmissionFailure) {
                singleScaffoldMessenger(
                  context,
                  message: state.errorMessage ?? 'Failed to Add Category',
                  backgroundColor: Colors.red,
                );
              }
            },
          ),
          BlocListener<TaskerProfileInfoBloc, TaskerProfileInfoState>(
            listener: (context, state) {
              if (state.formStatus.isSubmissionSuccess) {
                BlocProvider.of<TaskerListBloc>(context)
                    .add(TaskerListFetched());
                singleScaffoldMessenger(
                  context,
                  message: 'User profile info updated successfully',
                  backgroundColor: Colors.blue,
                );
              } else if (state.formStatus.isSubmissionFailure) {
                singleScaffoldMessenger(
                  context,
                  message: state.errorMessage ?? 'Failed to update user info',
                  backgroundColor: Colors.red,
                );
              }
            },
          ),
          BlocListener<UserImageBloc, UserImageState>(
            listener: (context, state) {
              if (state.userImageStatus == UserImageStatus.success) {
                singleScaffoldMessenger(
                  context,
                  message: 'User profile info updated successfully',
                  backgroundColor: Colors.blue,
                );
              } else if (state.userImageStatus == UserImageStatus.failure) {
                singleScaffoldMessenger(
                  context,
                  message: state.errorMessage ??
                      'Failed to update user profile image',
                  backgroundColor: Colors.red,
                );
              }
            },
          ),
          BlocListener<MobileMoneyBloc, MobileMoneyState>(
            listener: (context, state) {
              if (state.formStatus.isSubmissionSuccess) {
                singleScaffoldMessenger(
                  context,
                  message: 'Request sent. Dial *126 or #150# and confirm.',
                  backgroundColor: Colors.blue,
                );
              } else if (state.formStatus.isSubmissionFailure) {
                singleScaffoldMessenger(
                  context,
                  message: state.errorMessage ?? 'Request failed. Try again.',
                  backgroundColor: Colors.red,
                );
              }
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
