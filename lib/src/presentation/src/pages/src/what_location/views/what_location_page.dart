import 'package:flutter/material.dart';

class WhatLocationPage extends StatelessWidget {
  const WhatLocationPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const WhatLocationPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("What location"),
      ),
      body: Container(),);
  }
}
