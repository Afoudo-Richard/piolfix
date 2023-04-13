import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingState) {
        return AppBar(
          excludeHeaderSemantics: true,
          automaticallyImplyLeading: automaticallyImplyLeading,
          elevation: 0.5,
          backgroundColor: settingState.isDarkMode
              ? darkSecondaryColor
              : backgroundColor ?? Colors.white,
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              color: primaryColor,
            ),
          ),
          centerTitle: centerTitle,
          actions: actions,
          iconTheme: IconThemeData(
            color: settingState.isDarkMode ? Colors.white : Colors.black,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(45.sp);
}
