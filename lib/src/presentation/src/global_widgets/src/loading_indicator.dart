import 'package:flutter/material.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poilfix/poilfix.dart';

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({
    Key? key,
    this.radius = 20,
    this.color = primaryColor,
    this.strokeWidth = 2,
  }) : super(key: key);

  final double radius;
  final Color color;
  final double strokeWidth;
  final double size = 30.sp;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: radius,
        height: radius,
        // child: CircularProgressIndicator(
        //   strokeWidth: strokeWidth,
        //   color: color,
        // ),
        child: LoadingAnimationWidget.hexagonDots(
          color: secondaryColor,
          size: radius,
        ),
      ),
    );
  }
}
