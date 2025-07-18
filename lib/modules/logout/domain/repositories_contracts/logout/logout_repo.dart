import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/logout/domain/entities/logout/logout_response_entity.dart';

abstract interface class LogoutRepo {
  Future<ApiResult<LogoutResponseEntity>> logout();
}
