import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'tasker_profile_info_event.dart';
part 'tasker_profile_info_state.dart';

class TaskerProfileInfoBloc
    extends Bloc<TaskerProfileInfoEvent, TaskerProfileInfoState> {
  TaskerProfileInfoBloc({required this.userBloc})
      : super(TaskerProfileInfoState(
          taskerTool: userBloc.state.user?.tools != null
              ? TaskerTool.dirty(userBloc.state.user!.tools ?? 'N/A')
              : const TaskerTool.pure(),
          taskerSkill: userBloc.state.user?.skills != null
              ? TaskerSkill.dirty(userBloc.state.user!.skills ?? 'N/A')
              : const TaskerSkill.pure(),
          taskerPricePerHr: userBloc.state.user?.pricePerHr != null
              ? TaskerPricePerHr.dirty(
                  userBloc.state.user?.pricePerHr.toString() ?? 'N/A')
              : const TaskerPricePerHr.pure(),
        )) {
    on<TaskerProfileInfoToolChanged>(_onTaskerProfileInfoToolChanged);
    on<TaskerProfileInfoSkillChanged>(_onTaskerProfileInfoSkillChanged);
    on<TaskerProfileInfoPricePerHrChanged>(
        _onTaskerProfileInfoPricePerHrChanged);

    on<TaskerProfileInfoInputsChecked>(_onTaskerProfileInfoInputsChecked);

    on<TaskerProfileInfoSubmitted>(_onTaskerProfileInfoSubmitted);
  }

  final UserBloc userBloc;

  Future<void> _onTaskerProfileInfoToolChanged(
    TaskerProfileInfoToolChanged event,
    Emitter<TaskerProfileInfoState> emit,
  ) async {
    final taskerTool = TaskerTool.dirty(event.value);
    emit(
      state.copyWith(
        taskerTool: taskerTool,
        formStatus: Formz.validate([
          taskerTool,
          state.taskerSkill,
          state.taskerPricePerHr,
        ]),
      ),
    );
  }

  Future<void> _onTaskerProfileInfoSkillChanged(
    TaskerProfileInfoSkillChanged event,
    Emitter<TaskerProfileInfoState> emit,
  ) async {
    final taskerSkill = TaskerSkill.dirty(event.value);
    emit(
      state.copyWith(
        taskerSkill: taskerSkill,
        formStatus: Formz.validate([
          taskerSkill,
          state.taskerTool,
          state.taskerPricePerHr,
        ]),
      ),
    );
  }

  Future<void> _onTaskerProfileInfoPricePerHrChanged(
    TaskerProfileInfoPricePerHrChanged event,
    Emitter<TaskerProfileInfoState> emit,
  ) async {
    final taskerPricePerHr = TaskerPricePerHr.dirty(event.value);
    emit(
      state.copyWith(
        taskerPricePerHr: taskerPricePerHr,
        formStatus: Formz.validate([
          state.taskerTool,
          state.taskerSkill,
          taskerPricePerHr,
        ]),
      ),
    );
  }

  Future<void> _onTaskerProfileInfoInputsChecked(
    TaskerProfileInfoInputsChecked event,
    Emitter<TaskerProfileInfoState> emit,
  ) async {
    emit(
      state.copyWith(
        taskerTool: TaskerTool.dirty(state.taskerTool.value),
        taskerPricePerHr: TaskerPricePerHr.dirty(state.taskerPricePerHr.value),
        taskerSkill: TaskerSkill.dirty(state.taskerSkill.value),
      ),
    );
  }

  Future<void> _onTaskerProfileInfoSubmitted(
    TaskerProfileInfoSubmitted event,
    Emitter<TaskerProfileInfoState> emit,
  ) async {
    if (state.formStatus.isValidated) {
      emit(
        state.copyWith(
          formStatus: FormzStatus.submissionInProgress,
        ),
      );

      try {
        User currentUser = await ParseUser.currentUser();
        final user = await _updateProfile(currentUser);
        userBloc.add(
          UserChanged(
            user: user,
          ),
        );
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionSuccess,
          ),
        );

        emit(
          state.copyWith(
            formStatus: FormzStatus.pure,
          ),
        );

        try {
          User user = userBloc.state.user!;
          await _sendUserNotification(
              user.objectId!, "Your profile was updated you are now a tasker.");
        } catch (e) {
          print("Errrrooooooooooorr @@@@@@@@@@@@@@##########");
        }
      } on ErrorUpdatingUserProfile catch (e) {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            errorMessage: e.message,
          ),
        );
      } catch (e) {
        emit(state.copyWith(
          formStatus: FormzStatus.submissionFailure,
          errorMessage: e.toString(),
        ));
      }
    }
  }

  Future _sendUserNotification(String id, String message) async {
    final ParseCloudFunction function =
        ParseCloudFunction('sendPushToUserAboutProfileStatus');

    final Map<String, dynamic> params = <String, dynamic>{
      'id': id,
      'message': message,
    };
    final ParseResponse parseResponse =
        await function.executeObjectFunction<ParseObject>(parameters: params);

    // ended here
    if (parseResponse.success && parseResponse.result != null) {
      print(parseResponse.result);
    }
  }

  Future<User> _updateProfile(User updateUser) async {
    var user = updateUser
      ..tools = state.taskerTool.value
      ..skills = state.taskerSkill.value
      ..status = UserStatus.active.name
      ..pricePerHr = state.taskerPricePerHr.value;

    var response = await user.save();

    if (response.success) {
      return user;
    } else {
      throw ErrorUpdatingUserProfile(message: response.error?.message);
    }
  }
}
