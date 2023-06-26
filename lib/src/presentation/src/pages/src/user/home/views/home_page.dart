import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:poilfix/poilfix.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, authState) {
                return ItemTile(
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  //   return CustomScaffold(
  //     body: RefreshIndicator(
  //       color: primaryColor,
  //       onRefresh: () => Future.sync(() {
  //         BlocProvider.of<CategoryListBloc>(context)
  //             .add(CategoryListFetched(refresh: true));

  //         BlocProvider.of<TaskerListBloc>(context)
  //             .add(TaskerListFetched(refresh: true));
  //       }),
  //       child: SingleChildScrollView(
  //         padding: pagePadding,
  //         child: Column(
  //           children: [
  //             4.h.ph,
  //             const UserLocation(),
  //             const Divider(),
  //             const UpdateUserProfile(),
  //             const HomeSearchInput(),
  //             2.h.ph,
  //             const TrendingProjects(),
  //             // 5.h.ph,
  //             // const InfoCard(),
  //             3.h.ph,
  //             const PopularTaskers(),
  //             // 2.h.ph,
  //             // ItemTile(
  //             //   icon: LineIcons.alternateSignOut,
  //             //   title: "LogOut",
  //             //   onTap: () {
  //             //     BlocProvider.of<AuthenticationBloc>(context).add(
  //             //       AuthenticationLogoutRequested(),
  //             //     );
  //             //   },
  //             // ),
  //             5.h.ph,
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'COGENI and SOREPCO has partnered with PiolFix for convinient and easy construction material assembly help.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
          ),
        ),
        2.h.ph,
        CustomContainer(
          padding: EdgeInsets.zero,
          boxShadow: [],
          height: 30.h,
          width: 100.w,
          child: Image.asset(
            'assets/images/user_bg_1.jpg',
            width: 100.w,
            height: 100.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class UserLocation extends StatelessWidget {
  const UserLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, UserMapPage.route());
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                LineIcons.mapMarker,
                color: primaryColor,
              ),
              2.w.pw,
              Text(
                'Deux Eglise, Akwa Area',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Icon(
            LineIcons.search,
            color: primaryColor,
          ),
        ],
      ),
    );
  }
}

class HomeSearchInput extends StatelessWidget {
  const HomeSearchInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          trans(context)!.i_need_help_with,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.grey,
          ),
        ),
        2.h.ph,
        GestureDetector(
          child: CustomInput(
            inputEnabled: false,
            leading: Icon(
              LineIcons.search,
              color: primaryColor,
            ),
            inputHintText: trans(context)!.try_mount_tv_or_leachy_faucet,
          ),
          onTap: () {
            BlocProvider.of<AppBottomNavigationBarBloc>(context)
                .add(AppBottomNavigationBarChanged(
              activePage: const TaskPage(),
            ));
          },
        ),
        // What are you looking for? 🤔
      ],
    );
  }
}

class TrendingProjects extends StatelessWidget {
  const TrendingProjects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: trans(context)!.trending_services,
          trailing: Text(
            trans(context)!.see_all,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: secondaryColor,
            ),
          ),
        ),
        2.h.ph,
        BlocBuilder<CategoryListBloc, CategoryListState>(
          builder: (context, state) {
            switch (state.categoryListStatus) {
              case CategoryListStatus.initial:
              case CategoryListStatus.refresh:
                return const ServicesLoading();
              case CategoryListStatus.failure:
                return FetchError(
                  onPressedTryAgain: () {
                    BlocProvider.of<CategoryListBloc>(context).add(
                      CategoryListFetched(refresh: true),
                    );
                  },
                );
              case CategoryListStatus.success:
                return AlignedGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.sp,
                  crossAxisSpacing: 35.sp,
                  itemCount:
                      state.categories.length < 6 ? state.categories.length : 6,
                  itemBuilder: (BuildContext context, int index) {
                    final categoryTitle = state.categories[index];
                    return CategoryItem(
                      category: categoryTitle,
                    );
                  },
                );
            }
          },
        ),
      ],
    );
  }
}

class PopularTaskers extends StatelessWidget {
  const PopularTaskers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: trans(context)!.popular_taskers,
          trailing: Text(
            trans(context)!.see_all,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: secondaryColor,
            ),
          ),
        ),
        2.h.ph,
        BlocBuilder<TaskerListBloc, TaskerListState>(
          builder: (context, state) {
            switch (state.taskerListStatus) {
              case TaskerListStatus.initial:
              case TaskerListStatus.refresh:
                return const TaskersLoading();

              case TaskerListStatus.failure:
                return FetchError(
                  onPressedTryAgain: () {
                    BlocProvider.of<TaskerListBloc>(context).add(
                      TaskerListFetched(refresh: true),
                    );
                  },
                );
              case TaskerListStatus.success:
                return TaskersListing(
                  taskers: state.taskers,
                  onScroll: () {
                    BlocProvider.of<TaskerListBloc>(context)
                        .add(TaskerListFetched());
                  },
                  hasReachedMax: state.hasReachedMax,
                );
            }
          },
        ),
        // ListView.separated(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (context, index) {
        //     // final category = categories[index];
        //     return const TaskerItem();
        //   },
        //   separatorBuilder: (context, index) {
        //     return 2.h.ph;
        //   },
        //   itemCount: 7,
        // ),
      ],
    );
  }
}
