import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/use_cases/logged_driver_data/get_logged_driver_data_use_case.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/di/injectable_initializer.dart';
import '../../../../../../shared_layers/localization/l10n_manager/localization_manager.dart';

part 'profile_state.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getLoggedDriverDataUseCase) : super(const ProfileState());
  final GetLoggedDriverDataUseCase _getLoggedDriverDataUseCase;

  void doIntent(ProfileIntent intent) async {
    switch (intent) {
      case LoadProfileIntent():
        _loadProfileData();
    }
  }

  Future<void> _loadProfileData() async {
    emit(state.copyWith(loadProfileStatus: LoadProfileStatus.loading));
    var result = await _getLoggedDriverDataUseCase.call();
    switch (result) {
      case Success<LoggedDriverDataResponseEntity>():
        emit(
          state.copyWith(
            loadProfileStatus: LoadProfileStatus.success,
            loggedDriverDataResponseEntity: result.data,
          ),
        );
      case Error<LoggedDriverDataResponseEntity>():
        emit(
          state.copyWith(
            loadProfileStatus: LoadProfileStatus.error,
            loadProfileError: result.error,
          ),
        );
    }
  }

  void changeLocale(String locale) {
    log('locale: $locale');
    getIt<LocalizationManager>().changeLocal(locale);
  }
}

sealed class ProfileIntent {}

class LoadProfileIntent extends ProfileIntent {}
