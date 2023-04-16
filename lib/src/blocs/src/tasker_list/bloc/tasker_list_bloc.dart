import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'tasker_list_event.dart';
part 'tasker_list_state.dart';

const _duration = Duration(milliseconds: 300);

class TaskerListBloc extends Bloc<TaskerListEvent, TaskerListState> {
  TaskerListBloc() : super(TaskerListState()) {
    on<TaskerListFetched>(
      _onTaskerListFetched,
      transformer: debounce(
        _duration,
      ),
    );
  }

  Future<void> _onTaskerListFetched(
    TaskerListFetched event,
    Emitter<TaskerListState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }
    try {
      if (state.taskerListStatus == TaskerListStatus.initial || event.refresh) {
        if (event.refresh) {
          emit(state.copyWith(
            taskerListStatus: TaskerListStatus.refresh,
          ));
        }
        final taskers = await _fetchTaskers();

        return emit(state.copyWith(
          taskerListStatus: TaskerListStatus.success,
          taskers: taskers,
          hasReachedMax: taskers.length < AppConfigs.fetchLimit ? true : false,
        ));
      }

      final taskers = await _fetchTaskers(startIndex: state.taskers.length);

      emit(
        taskers.isEmpty
            ? state.copyWith(hasReachedMax: true)
            : state.copyWith(
                taskerListStatus: TaskerListStatus.success,
                taskers: List.of(state.taskers)..addAll(taskers),
                hasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(
        state.copyWith(taskerListStatus: TaskerListStatus.failure),
      );
    }
  }

  Future<List<User>> _fetchTaskers({
    int startIndex = 0,
    int limit = AppConfigs.fetchLimit,
  }) async {
    QueryBuilder<User> query = QueryBuilder(User())
      ..setAmountToSkip(startIndex)
      ..orderByDescending('createdAt')
      // ..includeObject([
      //   'brand',
      //   'model',
      //   'condition_type',
      //   'fuel_type',
      //   'transmission_type',
      //   'user',
      //   'store',
      // ])
      ..whereEqualTo("status", UserStatus.active.name)
      ..setLimit(limit);

    return query.find();
  }
}
