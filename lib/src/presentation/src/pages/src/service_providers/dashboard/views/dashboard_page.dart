import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as ratingBar;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:poilfix/poilfix.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const DashboardPage());
  }

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingState) {
        return CustomScaffold(
          appBar: const CustomAppBar(
            title: 'Dashboard',
          ),
          body: SingleChildScrollView(
            padding: pagePadding,
            child: Column(
              children: [
                3.h.ph,
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Available",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: settingState.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            state.userAvailableStatus ==
                                    UserAvailableStatus.loading
                                ? Row(
                                    children: [
                                      LoadingIndicator(
                                        radius: 10,
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            4.w.pw,
                            Switch(
                              onChanged: (value) {
                                BlocProvider.of<UserBloc>(context)
                                    .add(IsUserAvailableChanged(value: value));
                              },
                              value: state.user != null
                                  ? state.user!.isAvailable
                                  : false,
                              activeColor: primaryColor,
                              activeTrackColor: secondaryColor,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: secondaryColor,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                3.h.ph,
                const AgencyStatsSection(),
                6.h.ph,
              ],
            ),
          ),
        );
      },
    );
  }
}

class AgencyStatsSection extends StatelessWidget {
  const AgencyStatsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> statsItems = [
      ValueStatItem(
        title: 'Total booking today',
        value: '80',
      ),
      ProgressStatItem(),
      RatingStatItem(),
      ValueStatItem(
        title: 'Active Task',
        value: '10',
        showArrow: false,
      ),
      ValueStatItem(
        title: 'Total Staffs',
        value: '5',
        showArrow: false,
      ),
      ValueStatItem(
        title: 'Popular Trips',
        value: '2',
        showArrow: false,
      ),
    ];
    return Column(
      children: [
        ValueStatItem(
          bgColor: Colors.blueAccent,
          titleTextStyle: TextStyle(color: Colors.white),
          valueTextStyle: TextStyle(color: Colors.white),
          title: 'Total Earnings today',
          value: '10,000,000 FCFA',
        ),
        4.h.ph,
        AlignedGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 15.sp,
          crossAxisSpacing: 10.sp,
          itemCount: statsItems.length,
          itemBuilder: (BuildContext context, int index) {
            return statsItems[index];
          },
        ),
      ],
    );
  }
}

class ValueStatItem extends StatelessWidget {
  final String title;
  final String value;
  final bool showArrow;
  final TextStyle? titleTextStyle;
  final TextStyle? valueTextStyle;
  final Color? bgColor;

  const ValueStatItem({
    super.key,
    required this.title,
    required this.value,
    this.showArrow = true,
    this.titleTextStyle,
    this.valueTextStyle,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      backgroundColor: bgColor,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 10.sp,
            ).merge(titleTextStyle),
          ),
          1.h.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 20.sp,
                ).merge(valueTextStyle),
              ),
              showArrow
                  ? Icon(
                      LineIcons.arrowDown,
                      color: Colors.red,
                      size: 10.sp,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressStatItem extends StatelessWidget {
  const ProgressStatItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Text(
            'Todays MileStone',
            style: TextStyle(
              fontSize: 10.sp,
            ),
          ),
          1.h.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '80%',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          1.h.ph,
          Text(
            'Completed',
            style: TextStyle(fontSize: 10.sp, color: primaryColor),
          ),
        ],
      ),
    );
  }
}

class RatingStatItem extends StatelessWidget {
  const RatingStatItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        children: [
          Text(
            'Users rating',
            style: TextStyle(
              fontSize: 10.sp,
            ),
          ),
          1.h.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '3.5/5',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
          1.h.ph,
          ratingBar.RatingBar.builder(
            initialRating: 3.5,
            allowHalfRating: true,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize:
                SizerUtil.deviceType == DeviceType.mobile ? 15.sp : 7.5.sp,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ],
      ),
    );
  }
}
