import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TaskDetailPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Task Details',
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.h.ph,
            CustomInput(
              inputMaxLines: 9,
              label: 'Task Detail',
              inputHintText:
                  'For example, what supplies are needed, where to park or timing restrictions',
              backgroundColor: Colors.white.withOpacity(0.7),
              labelTextStyle: const TextStyle(
                color: primaryColor,
              ),
              onChanged: (value) {},
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
                Navigator.push(context, TaskReviewPage.route());
              },
              child: Text(
                'Review Task',
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
