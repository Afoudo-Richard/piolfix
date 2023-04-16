part of 'tasker_profile_info_bloc.dart';

class TaskerProfileInfoState extends Equatable {
  final TaskerPricePerHr taskerPricePerHr;
  final TaskerSkill taskerSkill;
  final TaskerTool taskerTool;
  final FormzStatus formStatus;
  final String? errorMessage;

  TaskerProfileInfoState({
    this.taskerPricePerHr = const TaskerPricePerHr.pure(),
    this.taskerSkill = const TaskerSkill.pure(),
    this.taskerTool = const TaskerTool.pure(),
    this.formStatus = FormzStatus.pure,
    this.errorMessage,
  });

  @override
  List<Object?> get props {
    return [
      taskerPricePerHr,
      taskerSkill,
      taskerTool,
      formStatus,
      errorMessage,
    ];
  }

  TaskerProfileInfoState copyWith({
    TaskerPricePerHr? taskerPricePerHr,
    TaskerSkill? taskerSkill,
    TaskerTool? taskerTool,
    FormzStatus? formStatus,
    String? errorMessage,
  }) {
    return TaskerProfileInfoState(
      taskerPricePerHr: taskerPricePerHr ?? this.taskerPricePerHr,
      taskerSkill: taskerSkill ?? this.taskerSkill,
      taskerTool: taskerTool ?? this.taskerTool,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
