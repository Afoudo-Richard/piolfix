import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class TaskerProfilePage extends StatelessWidget {
  final User user;
  final bool showSelect;
  const TaskerProfilePage({
    super.key,
    required this.user,
    this.showSelect = false,
  });

  static Route route(User user, {bool showSelect = false}) {
    return MaterialPageRoute<void>(
        builder: (_) => TaskerProfilePage(
              user: user,
              showSelect: showSelect,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TaskerProfileBloc(tasker: user)..add(TaskerProfileReviewsFetched()),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return CustomScaffold(
            appBar: const CustomAppBar(
              title: 'Tasker Profile',
            ),
            body: SingleChildScrollView(
              padding: pagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  4.h.ph,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: user.objectId!,
                        child: CustomContainer(
                          padding: EdgeInsets.zero,
                          boxShadow: const [],
                          height: 90.sp,
                          width: 100.sp,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: primaryColor,
                                color: secondaryColor,
                              ),
                            ),
                            imageUrl: user.profileImage != null
                                ? user.profileImageUrl!
                                : "https://ui-avatars.com/api/?name=${user.firstname}+${user.lastname}",
                          ),
                        ),
                      ),
                      2.w.pw,
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${user.firstname} ${user.lastname}',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: settingsState.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            1.h.ph,
                            // Row(
                            //   children: [
                            //     Icon(
                            //       LineIcons.star,
                            //       color: Colors.orange,
                            //       size: 10.sp,
                            //     ),
                            //     2.w.pw,
                            //     BlocBuilder<TaskerProfileBloc,
                            //         TaskerProfileState>(
                            //       builder: (context, state) {
                            //         return Text(
                            //           '5.0 (${state.reviewStatus == ReviewStatus.loading || state.reviewStatus == ReviewStatus.initial || state.reviewStatus == ReviewStatus.refresh ? '--' : state.totalReviews} Reviews)',
                            //           style: TextStyle(
                            //             fontSize: 10.sp,
                            //             color: settingsState.isDarkMode
                            //                 ? Colors.white
                            //                 : Colors.black,
                            //           ),
                            //         );
                            //       },
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      )
                    ],
                  ),
                  2.h.ph,
                  // const TaskerInfoTextItem(
                  //   icon: LineIcons.checkCircle,
                  //   text: '9 waiting inline jobs',
                  // ),
                  // 2.h.ph,
                  // const TaskerInfoTextItem(
                  //   icon: LineIcons.clock,
                  //   text: '2 hours minimum required',
                  // ),
                  2.h.ph,
                  TaskerInfoTextItem(
                    icon: LineIcons.tools,
                    text: "Tools: ${user.tools}",
                  ),
                  2.h.ph,
                  const TaskerInfoTextItem(
                    icon: LineIcons.comment,
                    text: "Speaks: English, French , Spanish",
                  ),
                  4.h.ph,
                  SkillsAndExperience(
                    user: user,
                  ),
                  3.h.ph,
                  UserReviews(
                    tasker: user,
                  ),
                ],
              ),
            ),
            bottomNavigationBar:
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
                return authState.authenticated
                    ? BlocBuilder<SelectTaskBloc, SelectTaskState>(
                        builder: (context, state) {
                          return state.service != null && showSelect
                              ? Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: settingsState.isDarkMode
                                            ? Color.fromARGB(35, 158, 158, 158)
                                            : Colors.black12,
                                        blurRadius: 16,
                                        spreadRadius: 0,
                                        offset: Offset(0, -8),
                                      ),
                                    ],
                                    color: settingsState.isDarkMode
                                        ? darkSecondaryColor
                                        : Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'FCFA ${user.pricePerHr}/hr',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                            color: settingsState.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                        10.w.pw,
                                        Expanded(
                                          child: CustomButton(
                                            onPressed: () {
                                              BlocProvider.of<SelectTaskBloc>(
                                                      context)
                                                  .add(SelectTaskTaskerChanged(
                                                      user));
                                              Navigator.push(context,
                                                  TaskDetailPage.route());
                                            },
                                            child: Text(
                                              'Select',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      )
                    : const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}

class SkillsAndExperience extends StatelessWidget {
  final User user;
  const SkillsAndExperience({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Skills and Experience"),
        2.h.ph,
        BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingsState) {
            return Text(
              '${user.skills}',
              style: TextStyle(
                fontSize: 12.sp,
                color: settingsState.isDarkMode ? Colors.white : Colors.black,
              ),
            );
          },
        ),
      ],
    );
  }
}

class UserReviews extends StatelessWidget {
  final User tasker;
  const UserReviews({
    super.key,
    required this.tasker,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: "User Reviews",
              trailing: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    barrierColor: primaryColor.withOpacity(0.7),
                    isScrollControlled: true,
                    context: context,
                    builder: (ctx) {
                      return AddTaskerReviewBottomSheet(
                        tasker: tasker,
                      );
                    },
                  );
                },
                child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, authState) {
                    return BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return authState.authenticated &&
                                state.user!.objectId != tasker.objectId
                            ? Text(
                                "Add",
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: settingsState.isDarkMode
                                      ? Colors.white
                                      : secondaryColor,
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
            ),
            2.h.ph,
            BlocBuilder<TaskerProfileBloc, TaskerProfileState>(
              builder: (context, state) {
                return state.reviews.isNotEmpty
                    ? Row(
                        children: [
                          Icon(
                            LineIcons.star,
                            color: Colors.orange,
                            size: 10.sp,
                          ),
                          2.w.pw,
                          BlocBuilder<TaskerProfileBloc, TaskerProfileState>(
                            builder: (context, state) {
                              return Text(
                                '5.0 (${state.reviewStatus == ReviewStatus.loading || state.reviewStatus == ReviewStatus.initial || state.reviewStatus == ReviewStatus.refresh ? '--' : state.totalReviews} Reviews)',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: settingsState.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : const SizedBox.shrink();
              },
            ),
            // 2.h.ph,
            // Column(
            //   children: const [
            //     ReviewTile(
            //       ratingValue: '5',
            //       level: 70,
            //     ),
            //     ReviewTile(
            //       ratingValue: '4',
            //       level: 20,
            //     ),
            //     ReviewTile(
            //       ratingValue: '3',
            //       level: 10,
            //     ),
            //     ReviewTile(
            //       ratingValue: '2',
            //       level: 0,
            //     ),
            //     ReviewTile(
            //       ratingValue: '1',
            //       level: 20,
            //     ),
            //   ],
            // ),
            3.h.ph,
            BlocBuilder<TaskerProfileBloc, TaskerProfileState>(
              builder: (context, state) {
                switch (state.reviewStatus) {
                  case ReviewStatus.initial:
                  case ReviewStatus.loading:
                  case ReviewStatus.refresh:
                    return LoadingIndicator();
                  case ReviewStatus.success:
                    return Column(
                      children: [
                        state.reviews.isEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No reviews yet",
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: settingsState.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final review = state.reviews[index];
                                  return IndividualReview(
                                    review: review,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return 2.h.ph;
                                },
                                itemCount: state.reviews.length > 2
                                    ? 2
                                    : state.reviews.length,
                              ),
                        state.reviews.length > 2
                            ? Column(
                                children: [
                                  2.h.ph,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                        backgroundColor: Colors.white,
                                        border: const BorderSide(
                                            color: primaryColor),
                                        child: Text(
                                          'See All Reviews',
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            barrierColor:
                                                primaryColor.withOpacity(0.7),
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (ctx) {
                                              return BlocProvider.value(
                                                value: BlocProvider.of<
                                                    TaskerProfileBloc>(context),
                                                child: const AllReviews(),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  case ReviewStatus.failure:
                    return FetchError(
                      onPressedTryAgain: () =>
                          BlocProvider.of<TaskerProfileBloc>(context)
                              .add(TaskerProfileReviewsFetched(refresh: true)),
                    );
                }
              },
            ),

            3.h.ph,
          ],
        );
      },
    );
  }
}

class ReviewTile extends StatelessWidget {
  final String ratingValue;
  final double level;

  const ReviewTile({
    super.key,
    required this.ratingValue,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ratingValue,
          style: TextStyle(
            fontSize: 10.sp,
          ),
        ),
        1.w.pw,
        Icon(
          LineIcons.starAlt,
          color: Colors.orange,
          size: 15.sp,
        ),
        1.h.pw,
        Expanded(
          child: RatingBar(
            level: level,
          ),
        ),
      ],
    );
  }
}

class RatingBar extends StatelessWidget {
  final double level;
  const RatingBar({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: primaryColor,
            ),
          ),
        ),
        Container(
          width: level.w,
          height: 1.h,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

class TaskerInfoTextItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const TaskerInfoTextItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 14.sp,
            ),
            2.w.pw,
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: settingsState.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
