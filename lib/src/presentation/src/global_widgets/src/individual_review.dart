import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as ratingBar;

class IndividualReview extends StatelessWidget {
  final ReviewModel review;
  const IndividualReview({
    Key? key,
    required this.review,
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
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  color: secondaryColor,
                ),
              ),
              imageUrl: review.user?.profileImageUrl != null
                  ? review.user!.profileImageUrl!
                  : "https://ui-avatars.com/api/?name=${review.user!.firstname}+${review.user!.lastname}",
            ),
          ),
          3.w.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${review.user!.firstname} ${review.user!.lastname}',
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
                  initialRating: review.rating!.toDouble(),
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
                  review.review ?? 'N/A',
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
