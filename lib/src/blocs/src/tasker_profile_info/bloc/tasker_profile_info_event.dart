part of 'tasker_profile_info_bloc.dart';

abstract class TaskerProfileInfoEvent extends Equatable {
  const TaskerProfileInfoEvent();
  @override
  List<Object> get props => [];
}

class TaskerProfileInfoChanged extends TaskerProfileInfoEvent {}

class TaskerProfileInfoToolChanged extends TaskerProfileInfoEvent {
  const TaskerProfileInfoToolChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class TaskerProfileInfoSkillChanged extends TaskerProfileInfoEvent {
  const TaskerProfileInfoSkillChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class TaskerProfileInfoPricePerHrChanged extends TaskerProfileInfoEvent {
  const TaskerProfileInfoPricePerHrChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class TaskerProfileInfoInputsChecked extends TaskerProfileInfoEvent {}

class TaskerProfileInfoSubmitted extends TaskerProfileInfoEvent {}
