import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:poilfix/poilfix.dart';
import 'package:sizer/sizer.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBottomNavigationBarBloc, AppBottomNavigationBarState>(
      builder: (context, state) {
        return Container(
          height: 50.sp,
          padding: EdgeInsets.symmetric(horizontal: 25.sp, vertical: 0),
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                color: Colors.black12,
                blurRadius: 16,
                spreadRadius: 0,
                offset: Offset(0, -8),
              ),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp),
            ),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNavItem(
                    active: state.activePage is HomePage,
                    icon: LineIcons.home,
                    text: "Home",
                    onTap: () {
                      BlocProvider.of<AppBottomNavigationBarBloc>(context)
                          .add(AppBottomNavigationBarChanged(
                        activePage: const HomePage(),
                      ));
                    },
                    isExplorer: true,
                  ),
                  BottomNavItem(
                    active: state.activePage is TaskPage,
                    icon: LineIcons.calendarCheck,
                    text: "Task",
                    onTap: () {
                      BlocProvider.of<AppBottomNavigationBarBloc>(context)
                          .add(AppBottomNavigationBarChanged(
                        activePage: const TaskPage(),
                      ));
                    },
                    isExplorer: true,
                  ),
                  BottomNavItem(
                    active: state.activePage is MyTaskersPage,
                    icon: LineIcons.heart,
                    text: "My Taskers",
                    onTap: () {
                      BlocProvider.of<AppBottomNavigationBarBloc>(context)
                          .add(AppBottomNavigationBarChanged(
                        activePage: const MyTaskersPage(),
                      ));
                    },
                    isExplorer: true,
                  ),
                  BottomNavItem(
                    active: state.activePage is ProfilePage,
                    icon: LineIcons.user,
                    text: "Profile",
                    onTap: () {
                      BlocProvider.of<AppBottomNavigationBarBloc>(context)
                          .add(AppBottomNavigationBarChanged(
                        activePage: const ProfilePage(),
                      ));
                    },
                    isExplorer: true,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}