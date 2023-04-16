// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'select_task_bloc.dart';

class SelectTaskState extends Equatable {
  final Category? service;
  final User? tasker;

  SelectTaskState({
    this.service,
    this.tasker,
  });

  @override
  List<Object?> get props => [service, tasker];

  SelectTaskState copyWith({
    Category? service,
    User? tasker,
  }) {
    return SelectTaskState(
      service: service ?? this.service,
      tasker: tasker ?? this.tasker,
    );
  }
}
