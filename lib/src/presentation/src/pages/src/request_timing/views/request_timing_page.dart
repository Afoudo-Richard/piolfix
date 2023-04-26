import 'package:flutter/material.dart';

class RequestTimingPage extends StatelessWidget {
  const RequestTimingPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RequestTimingPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request timing"),
      ),
      body: Container(),);
  }
}
