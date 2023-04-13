import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: const AppDrawer(),
      body:
          BlocBuilder<AppBottomNavigationBarBloc, AppBottomNavigationBarState>(
        builder: (context, state) {
          return state.activePage;
        },
      ),
      bottomNavigationBar: const AppBottomNavigationBar(),
    );
  }
}
