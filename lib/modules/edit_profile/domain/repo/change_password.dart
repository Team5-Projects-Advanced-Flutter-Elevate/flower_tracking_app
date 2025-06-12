import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/entity/change_password.dart';

abstract class ChangePasswordRepo {
  Future<ApiResult<ChangePasswordEntity>> changePassword(
    String? password,
    String? newPassword,
  );
}
