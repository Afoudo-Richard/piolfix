// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasker_list_bloc.dart';

enum TaskerListStatus { initial, success, failure, refresh }

class TaskerListState extends Equatable {
  final List<User> taskers;
  final TaskerListStatus taskerListStatus;
  final bool hasReachedMax;
  final String? errorMessage;

  TaskerListState({
    this.taskers = const <User>[],
    this.taskerListStatus = TaskerListStatus.initial,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
        taskers,
        taskerListStatus,
        hasReachedMax,
        errorMessage,
      ];

  TaskerListState copyWith({
    List<User>? taskers,
    TaskerListStatus? taskerListStatus,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return TaskerListState(
      taskers: taskers ?? this.taskers,
      taskerListStatus: taskerListStatus ?? this.taskerListStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
