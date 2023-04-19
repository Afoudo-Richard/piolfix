import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:poilfix/poilfix.dart';
import 'package:sizer/sizer.dart';

class AllReviews extends StatelessWidget {
  const AllReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SectionHeader(
              title: "Reviews",
              trailing: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  LineIcons.times,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: pagePadding,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return IndividualReview();
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: 10,
                        );
                      },
                      itemCount: 7,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
