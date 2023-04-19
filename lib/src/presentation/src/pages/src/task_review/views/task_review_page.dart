import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class TaskReviewPage extends StatelessWidget {
  const TaskReviewPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TaskReviewPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: "Task review",
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.h.ph,
            Text(
              'Task Review here.....',
              style: TextStyle(
                fontSize: 14.sp,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: SizedBox(
            width: 100.w,
            child: CustomButton(
              onPressed: () {
                Navigator.push(context, SelectPaymentMethodPage.route());
              },
              child: Text(
                'Confirm and Pay',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
