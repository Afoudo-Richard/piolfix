import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomAppBar(
        title: 'Settings',
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingState) {
          return SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                2.h.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Dark Mode",
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: settingState.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Switch(
                      onChanged: (value) {
                        BlocProvider.of<SettingsBloc>(context)
                            .add(IsDarkModeChanged(value: value));
                      },
                      value: settingState.isDarkMode,
                      activeColor: primaryColor,
                      activeTrackColor: secondaryColor,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: secondaryColor,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}