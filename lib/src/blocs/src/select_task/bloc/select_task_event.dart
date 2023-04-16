part of 'select_task_bloc.dart';

abstract class SelectTaskEvent extends Equatable {
  const SelectTaskEvent();
  @override
  List<Object> get props => [];
}

class SelectTaskServiceChanged extends SelectTaskEvent {
  final Category service;
  const SelectTaskServiceChanged(this.service);
  @override
  List<Object> get props => [service];
}

class SelectTaskTaskerChanged extends SelectTaskEvent {
  final User tasker;
  const SelectTaskTaskerChanged(this.tasker);
  @override
  List<Object> get props => [tasker];
}
