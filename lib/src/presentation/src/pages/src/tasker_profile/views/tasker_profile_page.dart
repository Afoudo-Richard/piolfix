import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class TaskerProfilePage extends StatelessWidget {
  const TaskerProfilePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TaskerProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  CustomContainer(
                    padding: EdgeInsets.zero,
                    boxShadow: [],
                    height: 15.h,
                    width: 30.w,
                    child: Image.asset(
                      'assets/images/user1.jpeg',
                      width: 100.w,
                      height: 100.h,
                      fit: BoxFit.cover,
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
                                'Mubifor Marcellus',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        1.h.ph,
                        Row(
                          children: [
                            Icon(
                              LineIcons.star,
                              color: Colors.orange,
                              size: 10.sp,
                            ),
                            2.w.pw,
                            Text(
                              '5.0 (11 Reviews)',
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              2.h.ph,
              const TaskerInfoTextItem(
                icon: LineIcons.checkCircle,
                text: '9 waiting inline jobs',
              ),
              2.h.ph,
              const TaskerInfoTextItem(
                icon: LineIcons.clock,
                text: '2 hours minimum required',
              ),
              2.h.ph,
              const TaskerInfoTextItem(
                icon: LineIcons.tools,
                text: "Tools: I don't use tools",
              ),
              2.h.ph,
              const TaskerInfoTextItem(
                icon: LineIcons.comment,
                text: "Speeks: English, French , Spanish",
              ),
              4.h.ph,
              const SkillsAndExperience(),
              3.h.ph,
              UserReviews(),
            ],
          ),
        ));
  }
}

class SkillsAndExperience extends StatelessWidget {
  const SkillsAndExperience({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "Skills and Experience"),
        2.h.ph,
        Text(
          'Happy to wait as long as neccesary, can give updates if asked on where I am so far while waiting the task to be completed.',
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class UserReviews extends StatelessWidget {
  const UserReviews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: "User Reviews"),
        2.h.ph,
        Row(
          children: [
            Icon(
              LineIcons.star,
              color: Colors.orange,
              size: 10.sp,
            ),
            2.w.pw,
            Text(
              '5.0 (11 Reviews)',
              style: TextStyle(
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
        2.h.ph,
        Column(
          children: const [
            ReviewTile(
              ratingValue: '5',
              level: 70,
            ),
            ReviewTile(
              ratingValue: '4',
              level: 20,
            ),
            ReviewTile(
              ratingValue: '3',
              level: 10,
            ),
            ReviewTile(
              ratingValue: '2',
              level: 0,
            ),
            ReviewTile(
              ratingValue: '1',
              level: 20,
            ),
          ],
        ),
        2.h.ph,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const IndividualReview();
          },
          separatorBuilder: (context, index) {
            return 2.h.ph;
          },
          itemCount: 7,
        ),
      ],
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
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
          size: 14.sp,
        ),
        2.w.pw,
        Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}