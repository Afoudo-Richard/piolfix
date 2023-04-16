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
        return Scaffold(
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
                        return Expanded(
                          child: authState.authenticated
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${state.user!.firstname} ${state.user!.lastname}',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                      ),
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
                    ),
                    Icon(
                      LineIcons.edit,
                      color: primaryColor,
                    ),
                  ],
                ),
                5.h.ph,
                // ItemTile(
                //   icon: LineIcons.bell,
                //   title: "List Category",
                //   onTap: () => Navigator.push(
                //     context,
                //     CategoryListPage.route(),
                //   ),
                // ),
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
                ),
                ItemTile(
                  icon: LineIcons.cog,
                  title: "settings",
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
                ),
                ItemTile(
                  icon: LineIcons.headset,
                  title: "Contact Us",
                ),
                ItemTile(
                  icon: LineIcons.mobilePhone,
                  title: "App Info",
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
