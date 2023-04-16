import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class SelectPaymentMethodPage extends StatelessWidget {
  const SelectPaymentMethodPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const SelectPaymentMethodPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Select Payment Method",
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.h.ph,
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: SizedBox(
            width: 100.w,
            child: CustomButton(
              onPressed: () {
                Navigator.push(context, OrangeMtnMomoPaymentPage.route());
              },
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
