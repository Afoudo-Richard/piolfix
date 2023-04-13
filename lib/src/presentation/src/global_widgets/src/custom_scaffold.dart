import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const CustomScaffold({
    super.key,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingState) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: Scaffold(
              // extendBodyBehindAppBar: true,
              backgroundColor:
                  settingState.isDarkMode ? darkColor : Colors.white,
              appBar: appBar,
              body: body ?? Container(),
              bottomNavigationBar: bottomNavigationBar,
              floatingActionButton: floatingActionButton,
            ),
          ),
        );
      },
    );
  }
}
