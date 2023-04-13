import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class SelectTaskerPage extends StatelessWidget {
  const SelectTaskerPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SelectTaskerPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Select Tasker',
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                LineIcons.horizontalSliders,
                color: primaryColor,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              3.h.ph,
              CustomContainer(
                border: Border.all(color: secondaryColor),
                child: Row(
                  children: [
                    Icon(
                      LineIcons.userShield,
                      color: primaryColor,
                    ),
                    2.w.pw,
                    Expanded(
                      child: Text(
                        'Always have peace of mind. All taskers undergo ID and criminal background checks',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              4.h.ph,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // final category = categories[index];
                  return const TaskerItem();
                },
                separatorBuilder: (context, index) {
                  return 2.h.ph;
                },
                itemCount: 10,
              ),
            ],
          ),
        ));
  }
}
