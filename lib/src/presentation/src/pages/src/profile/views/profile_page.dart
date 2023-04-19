import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, authState) {
        return CustomScaffold(
          appBar: const CustomAppBar(
            title: 'Profile',
          ),
          body: SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.h.ph,
                Row(
                  children: [
                    const UserImage(),
                    2.w.pw,
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        return BlocBuilder<SettingsBloc, SettingsState>(
                          builder: (context, settingState) {
                            return Expanded(
                              child: authState.authenticated
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${state.user!.firstname} ${state.user!.lastname}',
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: settingState.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        Text(
                                          state.user!.email ?? 'N/A',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Anoymous',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
                                    ),
                            );
                          },
                        );
                      },
                    ),
                    Icon(
                      LineIcons.edit,
                      color: primaryColor,
                    ),
                  ],
                ),
                5.h.ph,
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return state.authenticated
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ItemTile(
                                icon: LineIcons.bell,
                                title: "List Category",
                                onTap: () => Navigator.push(
                                  context,
                                  CategoryListPage.route(),
                                ),
                              ),
                              ItemTile(
                                icon: LineIcons.book,
                                title: "My Tasker Profile",
                                onTap: () => Navigator.push(
                                  context,
                                  TaskerProfileInfoPage.route(),
                                ),
                              ),
                              ItemTile(
                                icon: LineIcons.bell,
                                title: "Notification",
                                trailing: CustomCircle(
                                  radius: 15.sp,
                                  color: primaryColor,
                                  child: Center(
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ItemTile(
                                icon: LineIcons.cog,
                                title: "Settings",
                                onTap: () {
                                  Navigator.push(context, SettingsPage.route());
                                },
                              ),
                              ItemTile(
                                icon: LineIcons.scroll,
                                title: "Terms & condition",
                              ),
                              ItemTile(
                                icon: LineIcons.userShield,
                                title: "Privacy policy",
                              ),
                              ItemTile(
                                icon: LineIcons.users,
                                title: "About Us",
                                onTap: () {
                                  Navigator.push(context, AboutAppPage.route());
                                },
                              ),
                              ItemTile(
                                icon: LineIcons.headset,
                                title: "Contact Us",
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  },
                ),
                ItemTile(
                  icon: LineIcons.alternateSignOut,
                  title: "LogOut",
                  onTap: () {
                    // BlocProvider.of<AuthenticationBloc>(context).add(
                    //   const AuthenticationHasWalkedThroughChanged(
                    //       hasWalkedThrough: false),
                    // );
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      AuthenticationLogoutRequested(),
                    );
                  },
                ),
                5.h.ph,
              ],
            ),
          ),
        );
      },
    );
  }
}
