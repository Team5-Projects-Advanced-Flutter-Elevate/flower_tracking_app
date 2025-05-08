import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';

abstract interface class LoginLocalDataSource {
  void saveDriverData({
    required LoggedDriverDataResponseEntity loggedDriverDataResponseEntity,
  });

  Future<LoggedDriverDataResponseEntity> getDriverData();

  Future<void> deleteDriverData();
  void saveRememberMeValue({required bool rememberMe});
  Future<bool> getRememberMeValue();
  Future<void> deleteRememberMeValue();
}
