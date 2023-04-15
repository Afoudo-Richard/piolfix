import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

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
        ],
        child: child,
      ),
    );
  }
}
