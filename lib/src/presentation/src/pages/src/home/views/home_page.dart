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
      body: RefreshIndicator(
        color: primaryColor,
        onRefresh: () => Future.sync(
          () => BlocProvider.of<CategoryListBloc>(context).add(
            CategoryListFetched(refresh: true),
          ),
        ),
        child: SingleChildScrollView(
          padding: pagePadding,
          child: Column(
            children: [
              4.h.ph,
              const UserLocation(),
              const Divider(),
              3.h.ph,
              const HomeSearchInput(),
              2.h.ph,
              const TrendingProjects(),
              5.h.ph,
              const InfoCard(),
              2.h.ph,
              const PopularTaskers(),
              3.h.ph,
            ],
          ),
        ),
      ),
    );
  }
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
            'assets/images/packaging.jpeg',
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
          'I need help with',
          style: TextStyle(
            fontSize: 18.sp,
          ),
        ),
        2.h.ph,
        CustomInput(
          leading: Icon(
            LineIcons.search,
            color: primaryColor,
          ),
          inputHintText: 'Try "mount Tv or leacky faucet',
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
          title: 'Trending Projects',
          trailing: Text(
            "See all",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: secondaryColor,
            ),
          ),
        ),
        2.h.ph,
        AlignedGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 15.sp,
          crossAxisSpacing: 10.sp,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            final String categoryTitle = categories[index];
            return CategoryItem(
              title: categoryTitle,
            );
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
          title: "Popular Tasker's",
          trailing: Text(
            "See all",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: secondaryColor,
            ),
          ),
        ),
        2.h.ph,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            // final category = categories[index];
            return const TaskerItem();
          },
          separatorBuilder: (context, index) {
            return 2.h.ph;
          },
          itemCount: 7,
        ),
      ],
    );
  }
}
