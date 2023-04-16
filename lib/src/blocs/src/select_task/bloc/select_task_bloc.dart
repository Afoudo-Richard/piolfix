import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'select_task_event.dart';
part 'select_task_state.dart';

class SelectTaskBloc extends Bloc<SelectTaskEvent, SelectTaskState> {
  SelectTaskBloc() : super(SelectTaskState()) {
    on<SelectTaskServiceChanged>(_onSelectTaskServiceChanged);
    on<SelectTaskTaskerChanged>(_onSelectTaskTaskerChanged);
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
}
