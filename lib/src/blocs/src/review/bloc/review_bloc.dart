import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final UserBloc userBloc;
  final User tasker;

  ReviewBloc({
    required this.userBloc,
    required this.tasker,
  }) : super(ReviewState(
          tasker: tasker,
        )) {
    on<ReviewMessageChanged>(_onReviewMessageChanged);
    on<ReviewRatingChanged>(_onReviewRatingChanged);
    on<ReviewInputsChecked>(_onReviewInputsChecked);

    on<ReviewSubmitted>(_onReviewSubmitted);
  }

  Future<void> _onReviewMessageChanged(
    ReviewMessageChanged event,
    Emitter<ReviewState> emit,
  ) async {
    final review = Review.dirty(event.review);
    emit(
      state.copyWith(
        review: review,
        formStatus: Formz.validate([
          review,
        ]),
      ),
    );
  }

  Future<void> _onReviewRatingChanged(
    ReviewRatingChanged event,
    Emitter<ReviewState> emit,
  ) async {
    final rating = Rating.dirty(event.rating.toString());
    emit(state.copyWith(
      rating: rating,
      formStatus: Formz.validate([
        state.review,
        rating,
      ]),
    ));
  }

  Future<void> _onReviewInputsChecked(
    ReviewInputsChecked event,
    Emitter<ReviewState> emit,
  ) async {
    emit(
      state.copyWith(
        review: Review.dirty(state.review.value),
        rating: Rating.dirty(state.rating.value),
      ),
    );
  }

  Future<void> _onReviewSubmitted(
    ReviewSubmitted event,
    Emitter<ReviewState> emit,
  ) async {
    if (state.formStatus.isValidated) {
      emit(state.copyWith(
        formStatus: FormzStatus.submissionInProgress,
      ));
      try {
        var review = ReviewModel()
          ..review = state.review.value
          ..rating = double.parse(state.rating.value)
          ..user = userBloc.state.user
          ..tasker = state.tasker;

        var response = await review.create();

        if (response.success) {
          print("Success");
        } else {
          print("An error occured here : ${response.toString()}");
          //throw ErrorAddingVehicle(message: response.error?.message);
        }

        emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
        emit(ReviewState());
      } on ErrorAddingReview catch (e) {
        emit(state.copyWith(
          errorMessage: e.getErrorsAsString ?? e.message,
          formStatus: FormzStatus.submissionFailure,
        ));
      } catch (_) {
        emit(state.copyWith(
          formStatus: FormzStatus.submissionFailure,
        ));
      }
    }
  }
}
