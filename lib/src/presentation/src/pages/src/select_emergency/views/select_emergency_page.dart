import 'package:flutter/material.dart';

class SelectEmergencyPage extends StatelessWidget {
  const SelectEmergencyPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SelectEmergencyPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select emergency"),
      ),
      body: Container(),);
  }
}
