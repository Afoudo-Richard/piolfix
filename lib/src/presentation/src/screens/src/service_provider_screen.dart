import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class ServiceProviderScreen extends StatelessWidget {
  const ServiceProviderScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const ServiceProviderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AppBottomNavigationBarBloc>(context)
            .add(AppBottomNavigationBarChanged(
          activePage: const ProfilePage(),
        ));

        return true;
      },
      child: Scaffold(
        // drawer: const AppDrawer(),
        body: BlocBuilder<AppBottomNavigationBarBloc,
            AppBottomNavigationBarState>(
          builder: (context, state) {
            return state.activePage;
          },
        ),
        bottomNavigationBar: const AppBottomNavigationBar(),
      ),
    );
  }
}
