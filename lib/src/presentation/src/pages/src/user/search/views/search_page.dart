import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SearchPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Container(),
    );
  }
}
