import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:bloc/bloc.dart';
import 'package:poilfix/poilfix.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<UserChanged>(_onUserChanged);
    on<UserLanguangeChanged>(_onUserLanguangeChanged);
    on<IsUserAvailableChanged>(_onIsUserAvailableChanged);
  }

  void _onUserChanged(
    UserChanged event,
    Emitter<UserState> emit,
  ) async {
    return emit(
      state.copyWith(
        user: event.user,
        checker: !state.checker,
      ),
    );
  }

  void _onUserLanguangeChanged(
    UserLanguangeChanged event,
    Emitter<UserState> emit,
  ) async {
    return emit(
      state.copyWith(
        locale: event.locale,
      ),
    );
  }

  void _onIsUserAvailableChanged(
    IsUserAvailableChanged event,
    Emitter<UserState> emit,
  ) async {
    if (state.user != null) {
      var user = state.user!..isAvailable = event.value;
      emit(
        state.copyWith(
          userAvailableStatus: UserAvailableStatus.loading,
          checker: !state.checker,
        ),
      );
      var response = await user.save();

      if (response.success) {
        emit(
          state.copyWith(
            userAvailableStatus: UserAvailableStatus.success,
            checker: !state.checker,
            user: user,
          ),
        );

        // state.copyWith(
        //   userAvailableStatus: UserAvailableStatus.initial,
        //   checker: !state.checker,
        // );
      } else {
        state.copyWith(
          userAvailableStatus: UserAvailableStatus.failure,
          checker: !state.checker,
        );
      }
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toMap();
  }
}
