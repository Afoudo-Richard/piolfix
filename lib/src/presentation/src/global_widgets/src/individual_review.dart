import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as ratingBar;

class IndividualReview extends StatelessWidget {
  const IndividualReview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 10.sp,
        horizontal: 5.sp,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCircle(
            radius: 40.sp,
            color: primaryColor,
            child: Image.asset(
              'assets/images/user1.jpeg',
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: deviceWidth(context) * 0.03,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Richard Arc',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      '23/03/2023',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                1.h.ph,
                ratingBar.RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 15.sp,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
                1.h.ph,
                Text(
                  'So prompt you where loved by everyone inline. So professional you knew exactly what to say. Rave review from everyone around you. You killed it. Thank you so much.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.sp,
                    letterSpacing: 1.5,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
