import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:poilfix/poilfix.dart';
import 'package:sizer/sizer.dart';

class AllReviews extends StatefulWidget {
  const AllReviews({Key? key}) : super(key: key);

  @override
  State<AllReviews> createState() => _AllReviewsState();
}

class _AllReviewsState extends State<AllReviews> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      BlocProvider.of<TaskerProfileBloc>(context)
          .add(TaskerProfileReviewsFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SectionHeader(
              title: "Reviews",
              trailing: InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  LineIcons.times,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: BlocBuilder<TaskerProfileBloc, TaskerProfileState>(
              builder: (context, state) {
                switch (state.reviewStatus) {
                  case ReviewStatus.initial:
                  case ReviewStatus.loading:
                  case ReviewStatus.refresh:
                    return LoadingIndicator();
                  case ReviewStatus.success:
                    return Padding(
                      padding: pagePadding,
                      child: ListView.separated(
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return index >= state.reviews.length
                              ? LoadingIndicator()
                              : IndividualReview(
                                  review: state.reviews[index],
                                );
                        },
                        separatorBuilder: (context, index) {
                          return 3.h.ph;
                        },
                        itemCount: state.reviewHasReachedMax
                            ? state.reviews.length
                            : state.reviews.length + 1,
                      ),
                    );
                  case ReviewStatus.failure:
                    return FetchError(
                      onPressedTryAgain: () =>
                          BlocProvider.of<TaskerProfileBloc>(context)
                              .add(TaskerProfileReviewsFetched(refresh: true)),
                    );
                }
              },
            ),
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     controller: _scrollController,
          //     child: Column(
          //       children: [
          //         Padding(
          //           padding: pagePadding,
          //           child: ListView.separated(
          //             physics: const NeverScrollableScrollPhysics(),
          //             shrinkWrap: true,
          //             itemBuilder: (context, index) {
          //               return IndividualReview();
          //             },
          //             separatorBuilder: (context, index) {
          //               return Divider(
          //                 height: 10,
          //               );
          //             },
          //             itemCount: 7,
          //           ),
          //         ),
          //         SizedBox(
          //           height: 2.h,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
