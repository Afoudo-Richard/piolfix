import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ContactUsPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: "Contact Us",
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
