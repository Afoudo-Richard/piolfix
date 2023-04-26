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

class SelectTaskTaskDetailsChanged extends SelectTaskEvent {
  const SelectTaskTaskDetailsChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class SelectTaskTaskerChanged extends SelectTaskEvent {
  final User tasker;
  const SelectTaskTaskerChanged(this.tasker);
  @override
  List<Object> get props => [tasker];
}

class SelectTaskTaskDetailsInputsChecked extends SelectTaskEvent {}

class SearchFilterSubmitted extends SelectTaskEvent {
  final bool refresh;
  final bool isFromButton;
  const SearchFilterSubmitted({this.refresh = false, this.isFromButton = true});
}
