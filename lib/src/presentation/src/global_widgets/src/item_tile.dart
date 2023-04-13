import "package:flutter/material.dart";
import 'package:poilfix/poilfix.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 20.sp,
                    color: primaryColor,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // Icon(
              //   LineIcons.angleRight,
              //   size: 15.sp,
              // ),
            ],
          ),
          3.h.ph,
        ],
      ),
    );
  }
}
