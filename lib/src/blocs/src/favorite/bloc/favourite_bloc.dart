import 'dart:convert';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:poilfix/poilfix.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends HydratedBloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteState()) {
    on<FavouriteUserAdded>(_onFavouriteUserAdded);
    on<FavouriteUserRemoved>(_onFavouriteUserRemoved);
    on<ClearedFavourite>(_onClearedFavourite);
  }

  void _onFavouriteUserAdded(
      FavouriteUserAdded event, Emitter<FavouriteState> emit) {
    state.userInFavourite(event.user)
        ? emit(
            state.copyWith(
              favouriteStatus: FavouriteStatus.userExist,
            ),
          )
        : emit(
            state.copyWith(
              users: List.of(state.users)..add(event.user),
              favouriteStatus: FavouriteStatus.userAdded,
            ),
          );
  }

  void _onFavouriteUserRemoved(
      FavouriteUserRemoved event, Emitter<FavouriteState> emit) {
    emit(
      state.copyWith(
        users: List.of(state.users)..remove(event.user),
        favouriteStatus: FavouriteStatus.userRemoved,
      ),
    );
  }

  void _onClearedFavourite(
      ClearedFavourite event, Emitter<FavouriteState> emit) {
    emit(
      state.copyWith(
        users: List.of(state.users)..clear(),
        favouriteStatus: FavouriteStatus.cleared,
      ),
    );
  }

  @override
  FavouriteState? fromJson(Map<String, dynamic> json) {
    return FavouriteState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(FavouriteState state) {
    return state.toMap();
  }
}
