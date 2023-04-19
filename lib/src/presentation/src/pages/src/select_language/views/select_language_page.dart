import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SelectLanguagePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Select language",
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select language here"),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 16,
              spreadRadius: 0,
              offset: Offset(0, -8),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                  onPressed: () {
                    Navigator.push(context, WalkThroughPage.route());
                  },
                  child: Row(
                    children: [
                      Text(
                        'Proceed',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          letterSpacing: 1.5,
                        ),
                      ),
                      2.w.pw,
                      Icon(
                        Icons.arrow_forward,
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
