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
    return CustomScaffold(
      appBar: CustomAppBar(
        title: trans(context)!.select_payment_method,
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.h.ph,
            Row(
              children: [
                CustomCircle(
                  radius: 15.sp,
                ),
                3.w.pw,
                Expanded(
                  child: Text(
                    'ORANGE/MTN Mobile Money',
                    style: TextStyle(
                      fontSize: 14.sp,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            3.h.ph,
            Row(
              children: [
                CustomCircle(
                  radius: 15.sp,
                ),
                3.w.pw,
                Expanded(
                  child: Text(
                    'VISA/MASTER CARD',
                    style: TextStyle(
                      fontSize: 14.sp,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            3.h.ph,
            Row(
              children: [
                CustomCircle(
                  radius: 15.sp,
                ),
                3.w.pw,
                Expanded(
                  child: Text(
                    'PayPal',
                    style: TextStyle(
                      fontSize: 14.sp,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: SizedBox(
            width: 100.w,
            child: CustomButton(
              onPressed: () {
                Navigator.push(context, OrangeMtnMomoPaymentPage.route());
              },
              child: Text(
                trans(context)!.continue_,
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
