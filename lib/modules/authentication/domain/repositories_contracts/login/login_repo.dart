import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import '../../entities/login/request/login_request_entity.dart';

abstract interface class LoginRepo {
  Future<ApiResult<LoggedDriverDataResponseEntity>> login({
    required LoginRequestEntity loginRequest,
    required bool rememberMe,
  });
}
