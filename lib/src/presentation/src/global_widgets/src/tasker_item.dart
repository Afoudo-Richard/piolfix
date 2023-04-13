import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:poilfix/poilfix.dart';

class TaskerItem extends StatelessWidget {
  const TaskerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, TaskerProfilePage.route());
      },
      child: CustomContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          2.w.pw,
                          Text(
                            'FCFA 1000/hr',
                            style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
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
                      1.h.ph,
                      Row(
                        children: [
                          Icon(
                            LineIcons.checkCircle,
                            color: Colors.orange,
                            size: 10.sp,
                          ),
                          2.w.pw,
                          Text(
                            '9 waiting inline jobs',
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      1.h.ph,
                      Row(
                        children: [
                          Icon(
                            LineIcons.clock,
                            color: Colors.orange,
                            size: 10.sp,
                          ),
                          2.w.pw,
                          Text(
                            '2 hours minimum required',
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
            1.5.h.ph,
            Text(
              'Happy to wait as long as neccesary, can give updates if asked on where I am so far while waiting the task to be completed',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey,
              ),
            ),
            1.h.ph,
            GestureDetector(
              child: Text(
                'See Profile',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
