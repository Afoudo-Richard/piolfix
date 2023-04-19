import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class MyTaskersPage extends StatelessWidget {
  const MyTaskersPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MyTaskersPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'My Taskers',
      ),
      body: Container(),
    );
  }
}
