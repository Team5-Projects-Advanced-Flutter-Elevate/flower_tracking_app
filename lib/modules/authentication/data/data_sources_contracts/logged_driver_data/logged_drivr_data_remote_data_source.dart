import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';

abstract interface class LoggedDriverDataRemoteDataSource{

  Future<ApiResult<LoggedDriverDataResponseEntity>> getLoggedDriverData();
}