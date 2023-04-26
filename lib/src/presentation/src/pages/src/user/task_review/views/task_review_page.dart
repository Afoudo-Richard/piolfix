import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class TaskReviewPage extends StatelessWidget {
  const TaskReviewPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TaskReviewPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectTaskBloc, SelectTaskState>(
      builder: (context, state) {
        return CustomScaffold(
          appBar: const CustomAppBar(
            title: "Task review",
          ),
          body: SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                3.h.ph,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomContainer(
                          padding: EdgeInsets.zero,
                          boxShadow: [],
                          height: 80.sp,
                          width: 90.sp,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: primaryColor,
                                color: secondaryColor,
                              ),
                            ),
                            imageUrl: state.tasker!.profileImageUrl != null
                                ? state.tasker!.profileImageUrl!
                                : "https://ui-avatars.com/api/?name=${state.tasker!.firstname}+${state.tasker!.lastname}",
                          ),
                        ),
                        1.h.ph,
                        Text(
                          '${state.tasker!.firstname} ${state.tasker!.lastname}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    3.w.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                LineIcons.calendarCheck,
                                color: Colors.grey,
                                size: 15.sp,
                              ),
                              2.w.pw,
                              Text(
                                'Friday - May 7, 2023',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          2.h.ph,
                          Row(
                            children: [
                              Icon(
                                LineIcons.clock,
                                color: Colors.grey,
                                size: 15.sp,
                              ),
                              2.w.pw,
                              Text(
                                '8:00 AM',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                3.h.ph,
                const SectionHeader(title: "Task Details"),
                1.h.ph,
                BlocBuilder<SelectTaskBloc, SelectTaskState>(
                  builder: (context, state) {
                    return Text(
                      state.taskDetails.value,
                      style: TextStyle(
                        fontSize: 12.sp,
                        letterSpacing: 1.5,
                      ),
                    );
                  },
                ),
                3.h.ph,
                SectionHeader(
                  title: "Total Rate:",
                  trailing: Text(
                    '${state.tasker!.pricePerHr}/hr',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey,
                    ),
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
      },
    );
  }
}
