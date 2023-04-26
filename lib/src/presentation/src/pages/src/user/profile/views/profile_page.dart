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
              appBar: CustomAppBar(
                title: trans(context)!.profile,
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
                                              ? trans(context)!.available
                                              : trans(context)!.offline,
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
                                      trans(context)!.anonymous,
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
                                                    title: trans(context)!
                                                        .dashboard,
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
                                    title: trans(context)!.info,
                                    children: [
                                      ItemTile(
                                        icon: LineIcons.cog,
                                        title: trans(context)!.settings,
                                        onTap: () {
                                          Navigator.push(
                                              context, SettingsPage.route());
                                        },
                                      ),
                                      ItemTile(
                                        icon: LineIcons.bell,
                                        title: trans(context)!.notifications,
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
                                    title: trans(context)!.legals,
                                    children: [
                                      ItemTile(
                                        icon: LineIcons.scroll,
                                        title: trans(context)!
                                            .terms_and_conditions,
                                        onTap: () {
                                          Navigator.push(context,
                                              TermsConditionsPage.route());
                                        },
                                      ),
                                      ItemTile(
                                        icon: LineIcons.userShield,
                                        title: trans(context)!.privacy_policy,
                                        onTap: () {
                                          Navigator.push(context,
                                              PrivacyPolicyPage.route());
                                        },
                                      ),
                                    ],
                                  ),
                                  SectionGrouping(
                                    title: trans(context)!.other,
                                    children: [
                                      ItemTile(
                                        icon: LineIcons.users,
                                        title: trans(context)!.about_app,
                                        onTap: () {
                                          Navigator.push(
                                              context, AboutAppPage.route());
                                        },
                                      ),
                                      ItemTile(
                                        icon: LineIcons.headset,
                                        title:
                                            "${trans(context)!.contact_us} / ${trans(context)!.support}",
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
                      title: authState.authenticated
                          ? trans(context)!.logout
                          : trans(context)!.login,
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
