// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'tasker_profile_bloc.dart';

enum ReviewStatus { initial, refresh, success, failure, loading }

enum ReviewLoadMoreStatus { initial, success, failure, loading }

class TaskerProfileState extends Equatable {
  final User? tasker;
  final List<ReviewModel> reviews;
  final ReviewStatus reviewStatus;
  final ReviewLoadMoreStatus reviewLoadMoreStatus;
  final int totalReviews;
  final String? errorMessage;
  final bool reviewHasReachedMax;

  TaskerProfileState({
    this.tasker,
    this.reviews = const [],
    this.reviewStatus = ReviewStatus.initial,
    this.reviewLoadMoreStatus = ReviewLoadMoreStatus.initial,
    this.totalReviews = 0,
    this.errorMessage,
    this.reviewHasReachedMax = false,
  });

  @override
  List<Object?> get props {
    return [
      tasker,
      reviews,
      reviewStatus,
      reviewLoadMoreStatus,
      totalReviews,
      errorMessage,
      reviewHasReachedMax,
    ];
  }

  TaskerProfileState copyWith({
    User? tasker,
    List<ReviewModel>? reviews,
    ReviewStatus? reviewStatus,
    ReviewLoadMoreStatus? reviewLoadMoreStatus,
    int? totalReviews,
    String? errorMessage,
    bool? reviewHasReachedMax,
  }) {
    return TaskerProfileState(
      tasker: tasker ?? this.tasker,
      reviews: reviews ?? this.reviews,
      reviewStatus: reviewStatus ?? this.reviewStatus,
      reviewLoadMoreStatus: reviewLoadMoreStatus ?? this.reviewLoadMoreStatus,
      totalReviews: totalReviews ?? this.totalReviews,
      errorMessage: errorMessage ?? this.errorMessage,
      reviewHasReachedMax: reviewHasReachedMax ?? this.reviewHasReachedMax,
    );
  }
}
