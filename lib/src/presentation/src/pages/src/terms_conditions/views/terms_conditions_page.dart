import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TermsConditionsPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: "Terms and Conditions",
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Terms and conditions here'),
          ],
        ),
      ),
    );
  }
}
