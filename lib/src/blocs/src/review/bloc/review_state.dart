// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'review_bloc.dart';

class ReviewState extends Equatable {
  final Review review;
  final Rating rating;
  final bool validRating;
  final FormzStatus formStatus;
  final String? errorMessage;
  final User? tasker;

  ReviewState({
    this.review = const Review.pure(),
    this.rating = const Rating.pure(),
    this.formStatus = FormzStatus.pure,
    this.errorMessage,
    this.validRating = true,
    this.tasker,
  });

  @override
  List<Object?> get props {
    return [
      review,
      rating,
      validRating,
      formStatus,
      errorMessage,
      tasker,
    ];
  }

  ReviewState copyWith({
    Review? review,
    Rating? rating,
    bool? validRating,
    FormzStatus? formStatus,
    String? errorMessage,
    User? tasker,
  }) {
    return ReviewState(
      review: review ?? this.review,
      rating: rating ?? this.rating,
      validRating: validRating ?? this.validRating,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      tasker: tasker ?? this.tasker,
    );
  }
}
