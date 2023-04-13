import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  const CategoryItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SelectTaskerPage.route(),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicWidth(
            child: CustomContainer(
              padding: EdgeInsets.zero,
              boxShadow: [],
              height: 15.h,
              width: 100.w,
              child: Image.asset(
                'assets/images/packaging2.jpg',
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
          1.h.ph,
          Text(
            title,
            style: TextStyle(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
