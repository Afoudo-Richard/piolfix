// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'select_task_bloc.dart';

enum SearchFilterStatus { initial, loading, success, failure, refresh }

class SelectTaskState extends Equatable {
  final Category? service;
  final User? tasker;
  final TaskDetails taskDetails;
  final List<User> taskers;
  final FormzStatus formStatus;
  final SearchFilterStatus searchFilterStatus;
  final bool hasReachedMax;

  const SelectTaskState({
    this.service,
    this.tasker,
    this.taskers = const [],
    this.taskDetails = const TaskDetails.pure(),
    this.formStatus = FormzStatus.pure,
    this.hasReachedMax = false,
    this.searchFilterStatus = SearchFilterStatus.initial,
  });

  @override
  List<Object?> get props => [
        service,
        tasker,
        taskers,
        taskDetails,
        hasReachedMax,
        searchFilterStatus,
        formStatus,
      ];

  SelectTaskState copyWith({
    Category? service,
    User? tasker,
    TaskDetails? taskDetails,
    List<User>? taskers,
    FormzStatus? formStatus,
    SearchFilterStatus? searchFilterStatus,
    bool? hasReachedMax,
  }) {
    return SelectTaskState(
      service: service ?? this.service,
      tasker: tasker ?? this.tasker,
      taskDetails: taskDetails ?? this.taskDetails,
      taskers: taskers ?? this.taskers,
      formStatus: formStatus ?? this.formStatus,
      searchFilterStatus: searchFilterStatus ?? this.searchFilterStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
