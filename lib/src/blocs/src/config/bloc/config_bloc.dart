import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:poilfix/poilfix.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(ConfigState()) {
    on<ConfigFetched>(_onConfigFetched);
  }

  Future<void> _onConfigFetched(
    ConfigFetched event,
    Emitter<ConfigState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          configListStatus: ConfigListStatus.loading,
        ),
      );
      final configs = await _fetchAppConfig();

      emit(
        state.copyWith(
            configListStatus: ConfigListStatus.success,
            privacyPolicy: configs['privacy_policy'],
            termsAndCondition: configs['terms_and_conditions']),
      );
    } on ErrorFetchingAppConfig catch (e) {
      emit(
        state.copyWith(
          configListStatus: ConfigListStatus.failure,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          configListStatus: ConfigListStatus.failure,
        ),
      );
    }
  }

  Future _fetchAppConfig() async {
    var response = await ParseConfig().getConfigs();

    if (response.success) {
      return response.result;
    } else {
      throw ErrorFetchingAppConfig(message: response.error!.message);
    }
  }
}
