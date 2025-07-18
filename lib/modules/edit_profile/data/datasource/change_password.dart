import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/change_password.dart';

abstract class ChangePasswordOnlineDataSource {
  Future<ApiResult<ChangePasswordEntity>> changePassword(
    String? password,
    String? newPassword,
  );
}
