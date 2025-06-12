import 'package:flower_tracking_app/modules/edit_profile/data/datasource/change_password.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/repo/change_password.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/change_password.dart';

@Injectable(as: ChangePasswordRepo)
class ChangePasswordRepoImpl implements ChangePasswordRepo {
  ChangePasswordOnlineDataSource changePasswordOnlineDataSource;
  ChangePasswordRepoImpl(this.changePasswordOnlineDataSource);

  @override
  Future<ApiResult<ChangePasswordEntity>> changePassword(
    String? password,
    String? newPassword,
  ) {
    // TODO: implement changePassword
    return changePasswordOnlineDataSource.changePassword(password, newPassword);
  }
}
