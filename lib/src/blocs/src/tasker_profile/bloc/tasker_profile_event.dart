part of 'tasker_profile_bloc.dart';

abstract class TaskerProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskerProfileChanged extends TaskerProfileEvent {}

class TaskerProfileFetched extends TaskerProfileEvent {
  final bool refresh;
  TaskerProfileFetched({this.refresh = false});
}

class TaskerProfileReviewsFetched extends TaskerProfileEvent {
  final bool refresh;
  TaskerProfileReviewsFetched({this.refresh = false});
}
