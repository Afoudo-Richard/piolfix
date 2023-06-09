import 'package:flutter/material.dart';
import 'package:poilfix/poilfix.dart';

class SelectTaskerPage extends StatelessWidget {
  const SelectTaskerPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SelectTaskerPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: trans(context)!.select_tasker,
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  barrierColor: primaryColor.withOpacity(0.7),
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) {
                    return const SearchFilterBottomSheet();
                  },
                );
              },
              icon: Icon(
                LineIcons.horizontalSliders,
                color: primaryColor,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            1.h.ph,
            Padding(
              padding: pagePadding,
              child: BlocBuilder<SelectTaskBloc, SelectTaskState>(
                builder: (context, state) {
                  return Text(
                    '${trans(context)!.task} : ${state.service!.name}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: primaryColor,
                    ),
                  );
                },
              ),
            ),
            2.h.ph,
            Expanded(
              child: BlocBuilder<SelectTaskBloc, SelectTaskState>(
                builder: (context, state) {
                  switch (state.searchFilterStatus) {
                    case SearchFilterStatus.initial:
                    case SearchFilterStatus.refresh:
                    case SearchFilterStatus.loading:
                      return Padding(
                        padding: pagePadding,
                        child: const TaskersLoading(),
                      );

                    case SearchFilterStatus.failure:
                      return FetchError(
                        onPressedTryAgain: () {
                          BlocProvider.of<SelectTaskBloc>(context).add(
                            const SearchFilterSubmitted(refresh: true),
                          );
                        },
                      );
                    case SearchFilterStatus.success:
                      return TaskersListing(
                        showSelect: true,
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.sp,
                          vertical: paddingSize,
                        ),
                        isScrollable: true,
                        taskers: state.taskers,
                        onScroll: () {
                          BlocProvider.of<SelectTaskBloc>(context)
                              .add(const SearchFilterSubmitted());
                        },
                        hasReachedMax: state.hasReachedMax,
                      );
                  }
                },
              ),
            ),

            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       UserSecurityInfo(),
            //       4.h.ph,
            //       // ListView.separated(
            //       //   shrinkWrap: true,
            //       //   physics: const NeverScrollableScrollPhysics(),
            //       //   itemBuilder: (context, index) {
            //       //     // final category = categories[index];
            //       //     return const TaskerItem();
            //       //   },
            //       //   separatorBuilder: (context, index) {
            //       //     return 2.h.ph;
            //       //   },
            //       //   itemCount: 10,
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}

class UserSecurityInfo extends StatelessWidget {
  const UserSecurityInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      border: Border.all(color: secondaryColor),
      child: Row(
        children: [
          Icon(
            LineIcons.userShield,
            color: primaryColor,
          ),
          2.w.pw,
          Expanded(
            child: Text(
              trans(context)!.always_have_peace_of_mind,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
