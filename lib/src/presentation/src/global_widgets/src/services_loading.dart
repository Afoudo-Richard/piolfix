import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:poilfix/poilfix.dart';
import 'package:shimmer/shimmer.dart';

class ServicesLoading extends StatelessWidget {
  const ServicesLoading({
    super.key,
    this.itemCount = 6,
    this.padding,
  });

  final int itemCount;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: AlignedGridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 15.sp,
        crossAxisSpacing: 10.sp,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          final String categoryTitle = categories[index];
          return Column(
            children: [
              IntrinsicWidth(
                child: CustomContainer(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  boxShadow: [],
                  height: 15.h,
                  width: 100.w,
                ),
              ),
              1.h.ph,
              Container(
                width: 80.w,
                height: 8.0,
                color: Colors.white,
              ),
            ],
          );
        },
      ),
    );
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: ListView.builder(
        padding: padding,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 60.sp,
                height: 60.sp,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    1.h.ph,
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    1.h.ph,
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    2.h.ph,
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        itemCount: itemCount,
      ),
    );
  }
}
