import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/di/injectable_initializer.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/use_cases/logged_driver_data/get_logged_driver_data_use_case.dart';
import 'package:flower_tracking_app/modules/logout/domain/entities/logout/logout_response_entity.dart';
import 'package:flower_tracking_app/modules/logout/domain/use_cases/logout/logout_use_case.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/constants/firestore_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._getLoggedDriverDataUseCase, this._logoutUseCase)
    : super(const ProfileState());
  final GetLoggedDriverDataUseCase _getLoggedDriverDataUseCase;
  final LogoutUseCase _logoutUseCase;

  void doIntent(ProfileIntent intent) async {
    switch (intent) {
      case LoadProfileIntent():
        _loadProfileData();
      case LogoutIntent():
        _logout();
    }
  }

  Future<void> _loadProfileData() async {
    if (isClosed) return; // Check before emitting
    emit(state.copyWith(loadProfileStatus: LoadProfileStatus.loading));
    var result = await _getLoggedDriverDataUseCase.call();
    if (isClosed) return; // Check after await
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

  Future<void> _logout() async {
    if (isClosed) return;
    emit(state.copyWith(logoutStatus: LogoutStatus.loading));
    var result = await _logoutUseCase.call();
    if (isClosed) return;
    switch (result) {
      case Success<LogoutResponseEntity>():
        // Unregister the DriverId from GetIt
        if (getIt.isRegistered<String>(
          instanceName: FirestoreConstants.driverId,
        )) {
          getIt.unregister<String>(instanceName: FirestoreConstants.driverId);
        }
        emit(state.copyWith(logoutStatus: LogoutStatus.success));
      case Error<LogoutResponseEntity>():
        emit(
          state.copyWith(
            logoutStatus: LogoutStatus.error,
            logoutError: result.error,
          ),
        );
    }
  }
}

sealed class ProfileIntent {}

class LoadProfileIntent extends ProfileIntent {}

class LogoutIntent extends ProfileIntent {}
