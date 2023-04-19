import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:poilfix/poilfix.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as ratingBar;

class AddTaskerReviewBottomSheet extends StatelessWidget {
  final User tasker;
  const AddTaskerReviewBottomSheet({
    Key? key,
    required this.tasker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewBloc(
        userBloc: BlocProvider.of<UserBloc>(context),
        tasker: tasker,
      ),
      child: Builder(builder: (context) {
        return BlocListener<ReviewBloc, ReviewState>(
          listener: (context, state) {
            if (state.formStatus.isSubmissionSuccess) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Review added successfully'),
                  ),
                );
            } else if (state.formStatus.isSubmissionFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.red,
                    content: Text(state.errorMessage ?? 'Failed to Add Review'),
                  ),
                );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                2.h.ph,
                Padding(
                  padding: pagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SectionHeader(
                          title: "Add Review",
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
                      2.h.ph,
                      BlocBuilder<ReviewBloc, ReviewState>(
                        builder: (context, state) {
                          return CustomInput(
                            inputMaxLines: 5,
                            label: 'Review',
                            inputHintText: 'Enter your review',
                            backgroundColor: Colors.white.withOpacity(0.7),
                            labelTextStyle: const TextStyle(
                              color: primaryColor,
                            ),
                            onChanged: (value) {
                              BlocProvider.of<ReviewBloc>(context)
                                  .add(ReviewMessageChanged(value));
                            },
                            inputErrorText: state.review.invalid
                                ? state.review.error
                                : null,
                          );
                        },
                      ),
                      3.h.ph,
                      BlocBuilder<ReviewBloc, ReviewState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Text(
                                "Rate this Tasker",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: primaryColor,
                                ),
                              ),
                              1.h.ph,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ratingBar.RatingBar.builder(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15.sp,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {
                                      BlocProvider.of<ReviewBloc>(context)
                                          .add(ReviewRatingChanged(rating));
                                    },
                                  ),
                                ],
                              ),
                              state.rating.invalid
                                  ? Text(
                                      state.rating.error!,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.red,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          );
                        },
                      ),
                      6.h.ph,
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<ReviewBloc, ReviewState>(
                              builder: (context, state) {
                                return CustomButton(
                                  backgroundColor:
                                      state.formStatus.isSubmissionInProgress
                                          ? Colors.grey
                                          : null,
                                  onPressed: () {
                                    state.formStatus.isValidated
                                        ? state.formStatus
                                                .isSubmissionInProgress
                                            ? null
                                            : context
                                                .read<ReviewBloc>()
                                                .add(const ReviewSubmitted())
                                        : BlocProvider.of<ReviewBloc>(context)
                                            .add(ReviewInputsChecked());
                                  },
                                  child: state.formStatus.isSubmissionInProgress
                                      ? LoadingIndicator(
                                          color: secondaryColor,
                                        )
                                      : Text(
                                          'Submit',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                            letterSpacing: 1.5,
                                          ),
                                        ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      2.h.ph,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
