import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';
import 'package:poilfix/src/presentation/presentation.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PrivacyPolicyPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: "Privacy policy",
      ),
      body: SingleChildScrollView(
        padding: pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('privacy policy here'),
          ],
        ),
      ),
    );
  }
}
