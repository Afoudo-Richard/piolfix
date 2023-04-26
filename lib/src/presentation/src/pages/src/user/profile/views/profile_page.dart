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
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, settingState) {
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
                                        Text(
                                          state.user!.isAvailable
                                              ? 'Available'
                                              : 'Offline',
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: state.user!.isAvailable
                                                ? Colors.green
                                                : Colors.red,
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
                        authState.authenticated
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context, EditPersonalInfoPage.route());
                                },
                                child: Icon(
                                  LineIcons.edit,
                                  color: primaryColor,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    2.h.ph,
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        return state.authenticated
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  2.h.ph,
                                  BlocBuilder<UserBloc, UserState>(
                                    builder: (context, state) {
                                      return state.user!.isServiceProvider
                                          ? SectionGrouping(
                                              title: 'PiolFixer',
                                              children: [
                                                ItemTile(
                                                    icon: LineIcons
                                                        .accessibleIcon,
                                                    title: "Dashboard",
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        ServiceProviderScreen
                                                            .route(),
                                                      );
                                                      BlocProvider.of<
                                                                  AppBottomNavigationBarBloc>(
                                                              context)
                                                          .add(
                                                              AppBottomNavigationBarChanged(
                                                        activePage:
                                                            const DashboardPage(),
                                                      ));
                                                    }),
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
                                                    TaskerProfileInfoPage
                                                        .route(),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox.shrink();
                                    },
                                  ),
                                  SectionGrouping(
                                    title: 'Info',
                                    children: [
                                      ItemTile(
                                        icon: LineIcons.cog,
                                        title: "Settings",
                                        onTap: () {
                                          Navigator.push(
                                              context, SettingsPage.route());
                                        },
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
                                    ],
                                  ),
                                  SectionGrouping(
                                    title: 'Legals',
                                    children: [
                                      ItemTile(
                                        icon: LineIcons.scroll,
                                        title: "Terms & condition",
                                        onTap: () {
                                          Navigator.push(context,
                                              TermsConditionsPage.route());
                                        },
                                      ),
                                      ItemTile(
                                        icon: LineIcons.userShield,
                                        title: "Privacy policy",
                                        onTap: () {
                                          Navigator.push(context,
                                              PrivacyPolicyPage.route());
                                        },
                                      ),
                                    ],
                                  ),
                                  SectionGrouping(
                                    title: 'Others',
                                    children: [
                                      ItemTile(
                                        icon: LineIcons.users,
                                        title: "About Us",
                                        onTap: () {
                                          Navigator.push(
                                              context, AboutAppPage.route());
                                        },
                                      ),
                                      ItemTile(
                                        icon: LineIcons.headset,
                                        title: "Contact Us / Support",
                                        onTap: () {
                                          Navigator.push(
                                              context, ContactUsPage.route());
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                    ItemTile(
                      icon: LineIcons.alternateSignOut,
                      title: authState.authenticated ? "LogOut" : 'Sign In',
                      onTap: () {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                          const AuthenticationHasWalkedThroughChanged(
                              hasWalkedThrough: false),
                        );
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
      },
    );
  }
}

class SectionGrouping extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const SectionGrouping({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        2.h.ph,
        ...children,
        const Divider(),
      ],
    );
  }
}
