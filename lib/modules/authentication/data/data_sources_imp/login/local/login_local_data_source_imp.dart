import 'dart:convert';

import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/login/local/login_local_data_source.dart';
import 'package:flower_tracking_app/shared_layers/storage/constants/storage_constants.dart';
import 'package:flower_tracking_app/shared_layers/storage/contracts/flutter_secure_storage_service_contract.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import '../../../models/logged_driver_data/logged_driver_data_response_dto.dart';

@Injectable(as: LoginLocalDataSource)
class LoginLocalDataSourceImp implements LoginLocalDataSource {
  final SecureStorageService _secureStorageService;

  LoginLocalDataSourceImp(this._secureStorageService);

  @override
  void saveDriverData({
    required LoggedDriverDataResponseEntity loggedDriverDataResponseEntity,
  }) {
    var driverDataDto = LoggedDriverDataResponseDto.convertIntDto(
      loggedDriverDataResponseEntity,
    );
    var driverDataString = jsonEncode(driverDataDto.toJson());
    _secureStorageService.setStringValue(
      StorageConstants.loginModelKey,
      driverDataString,
    );
  }

  @override
  Future<LoggedDriverDataResponseEntity> getDriverData() async {
    var json = await _secureStorageService.getStringValue(
      StorageConstants.loginModelKey,
    );
    var driverDto = LoggedDriverDataResponseDto.fromJson(
      jsonDecode(json ?? "{}"),
    );
    return driverDto.convertIntoEntity();
  }

  @override
  Future<void> deleteDriverData() {
    return _secureStorageService.deleteValue(StorageConstants.loginModelKey);
  }

  @override
  void saveRememberMeValue({required bool rememberMe}) {
    _secureStorageService.setStringValue(
      StorageConstants.rememberMeValueKey,
      rememberMe ? "true" : "false",
    );
  }

  @override
  Future<bool> getRememberMeValue() async {
    var valueString = await _secureStorageService.getStringValue(
      StorageConstants.rememberMeValueKey,
    );
    return valueString == 'true' ? true : false;
  }

  @override
  Future<void> deleteRememberMeValue() {
    return _secureStorageService.deleteValue(
      StorageConstants.rememberMeValueKey,
    );
  }
}
