import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: LoadingIndicator(
          radius: 30.sp,
        ),
      ),
    );
  }
}
