import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'tasker_profile_event.dart';
part 'tasker_profile_state.dart';

const _duration = Duration(milliseconds: 300);

class TaskerProfileBloc extends Bloc<TaskerProfileEvent, TaskerProfileState> {
  final User tasker;
  TaskerProfileBloc({
    required this.tasker,
  }) : super(TaskerProfileState()) {
    on<TaskerProfileFetched>(_onTaskerProfileFetched);
    on<TaskerProfileReviewsFetched>(
      _onTaskerProfileReviewsFetched,
      transformer: debounce(
        _duration,
      ),
    );
  }

  Future<void> _onTaskerProfileFetched(
    TaskerProfileFetched event,
    Emitter<TaskerProfileState> emit,
  ) async {
    // if (!event.refresh) {
    //   if (state.hasReachedMax) return;
    // } else {
    //   emit(state.copyWith(
    //     categoryListStatus: CategoryListStatus.initial,
    //   ));
    // }

    // try {
    //   final categories = await _fetchTasker();

    //   return emit(
    //     state.copyWith(
    //       categoryListStatus: CategoryListStatus.success,
    //       categories: categories,
    //       categoriesCopy: categories,
    //       hasReachedMax: true,
    //     ),
    //   );
    // } catch (e) {
    //   emit(state.copyWith(
    //     categoryListStatus: CategoryListStatus.failure,
    //   ));
    // }
  }

  Future<void> _onTaskerProfileReviewsFetched(
    TaskerProfileReviewsFetched event,
    Emitter<TaskerProfileState> emit,
  ) async {
    if (!event.refresh) {
      if (state.reviewHasReachedMax) return;
    }
    try {
      if (state.reviewStatus == ReviewStatus.initial || event.refresh) {
        if (event.refresh) {
          emit(state.copyWith(
            reviewStatus: ReviewStatus.refresh,
          ));
        }
        final reviews = await _fetchReviews();

        return emit(state.copyWith(
          reviewStatus: ReviewStatus.success,
          reviews: reviews,
          reviewHasReachedMax:
              reviews.length < AppConfigs.fetchLimit ? true : false,
        ));
      }

      final reviews = await _fetchReviews(startIndex: state.reviews.length);

      emit(
        reviews.isEmpty
            ? state.copyWith(reviewHasReachedMax: true)
            : state.copyWith(
                reviewStatus: ReviewStatus.success,
                reviews: List.of(state.reviews)..addAll(reviews),
                reviewHasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(
        state.copyWith(reviewStatus: ReviewStatus.failure),
      );
    }
  }

  // Future<User> _fetchTasker() async {
  //   QueryBuilder<User> query = QueryBuilder(User());
  //   query.whereEqualTo('objectId', tasker.objectId);
  //   return query.find();
  // }

  Future<List<ReviewModel>> _fetchReviews({
    int startIndex = 0,
    // int limit = AppConfigs.fetchLimit,
    int limit = 4,
  }) async {
    QueryBuilder<ReviewModel> query = QueryBuilder(ReviewModel())
      ..setAmountToSkip(startIndex)
      ..includeObject([
        'user',
      ])
      ..whereEqualTo('tasker', tasker)
      ..orderByDescending('createdAt')
      ..setLimit(limit);

    return query.find();
  }
}
