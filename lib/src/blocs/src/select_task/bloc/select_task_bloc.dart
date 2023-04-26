import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'select_task_event.dart';
part 'select_task_state.dart';

const _duration = Duration(milliseconds: 300);

class SelectTaskBloc extends Bloc<SelectTaskEvent, SelectTaskState> {
  SelectTaskBloc() : super(SelectTaskState()) {
    on<SelectTaskServiceChanged>(_onSelectTaskServiceChanged);
    on<SelectTaskTaskerChanged>(_onSelectTaskTaskerChanged);
    on<SelectTaskTaskDetailsInputsChecked>(
        _onSelectTaskTaskDetailsInputsChecked);
    on<SelectTaskTaskDetailsChanged>(_onSelectTaskTaskDetailsChanged);

    on<SearchFilterSubmitted>(
      _onSearchFilterSubmitted,
      transformer: debounce(
        _duration,
      ),
    );
  }

  Future<void> _onSelectTaskServiceChanged(
    SelectTaskServiceChanged event,
    Emitter<SelectTaskState> emit,
  ) async {
    emit(
      state.copyWith(
        service: event.service,
      ),
    );
  }

  Future<void> _onSelectTaskTaskerChanged(
    SelectTaskTaskerChanged event,
    Emitter<SelectTaskState> emit,
  ) async {
    emit(
      state.copyWith(
        tasker: event.tasker,
      ),
    );
  }

  void _onSelectTaskTaskDetailsChanged(
    SelectTaskTaskDetailsChanged event,
    Emitter<SelectTaskState> emit,
  ) {
    final taskDetails = TaskDetails.dirty(event.value);
    emit(state.copyWith(
      taskDetails: taskDetails,
      formStatus: Formz.validate([
        taskDetails,
      ]),
    ));
  }

  Future<void> _onSelectTaskTaskDetailsInputsChecked(
    SelectTaskTaskDetailsInputsChecked event,
    Emitter<SelectTaskState> emit,
  ) async {
    emit(
      state.copyWith(
        taskDetails: TaskDetails.dirty(state.taskDetails.value),
      ),
    );
  }

  void _onSearchFilterSubmitted(
    SearchFilterSubmitted event,
    Emitter<SelectTaskState> emit,
  ) async {
    if (!event.refresh) {
      if (state.hasReachedMax) return;
    }
    try {
      if (state.searchFilterStatus == SearchFilterStatus.initial ||
          event.refresh) {
        if (event.refresh || event.isFromButton) {
          emit(state.copyWith(
            searchFilterStatus: SearchFilterStatus.refresh,
          ));
        }
        final taskers = await _searchVehicles();

        return emit(state.copyWith(
          searchFilterStatus: SearchFilterStatus.success,
          taskers: taskers,
          hasReachedMax: taskers.length < AppConfigs.fetchLimit ? true : false,
        ));
      }

      final taskers = await _searchVehicles(
        startIndex: state.taskers.length,
      );

      emit(
        taskers.isEmpty
            ? state.copyWith(
                hasReachedMax: true,
              )
            : state.copyWith(
                searchFilterStatus: SearchFilterStatus.success,
                taskers: List.of(state.taskers)..addAll(taskers),
                hasReachedMax: false,
              ),
      );
    } catch (_) {
      emit(state.copyWith(
        searchFilterStatus: SearchFilterStatus.failure,
      ));
    }
  }

  Future<List<User>> _searchVehicles({
    int startIndex = 0,
    int limit = AppConfigs.fetchLimit,
  }) async {
    QueryBuilder<User> query = QueryBuilder(User())
      ..setAmountToSkip(startIndex)
      ..orderByDescending('createdAt')
      ..includeObject([
        'user',
      ])
      ..setLimit(limit);

    return query.find();
  }
}
