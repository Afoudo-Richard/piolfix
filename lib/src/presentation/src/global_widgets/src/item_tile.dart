import "package:flutter/material.dart";
import 'package:poilfix/poilfix.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingState) {
        return InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          size: 20.sp,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: settingState.isDarkMode
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                  trailing != null
                      ? Row(
                          children: [
                            2.w.pw,
                            trailing!,
                          ],
                        )
                      : const SizedBox.shrink(),
                  // Icon(
                  //   LineIcons.angleRight,
                  //   size: 15.sp,
                  // ),
                ],
              ),
              3.h.ph,
            ],
          ),
        );
      },
    );
  }
}
