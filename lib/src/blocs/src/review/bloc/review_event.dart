part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();
  @override
  List<Object> get props => [];
}

class ReviewChanged extends ReviewEvent {}

class ReviewMessageChanged extends ReviewEvent {
  const ReviewMessageChanged(this.review);

  final String review;

  @override
  List<Object> get props => [review];
}

class ReviewRatingChanged extends ReviewEvent {
  const ReviewRatingChanged(this.rating);

  final double rating;

  @override
  List<Object> get props => [rating];
}

class ReviewInputsChecked extends ReviewEvent {}

class ReviewSubmitted extends ReviewEvent {
  const ReviewSubmitted();
}
