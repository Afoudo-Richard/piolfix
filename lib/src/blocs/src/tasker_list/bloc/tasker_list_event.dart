part of 'tasker_list_bloc.dart';

abstract class TaskerListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TaskerListFetched extends TaskerListEvent {
  final bool refresh;
  TaskerListFetched({this.refresh = false});
}
