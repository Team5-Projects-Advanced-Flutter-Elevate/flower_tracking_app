import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/entity/change_password.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/repo/change_password.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {
  ChangePasswordRepo changePasswordRepo;

  ChangePasswordUseCase(this.changePasswordRepo);
  Future<ApiResult<ChangePasswordEntity>> call(
    String? password,
    String? newPassword,
  ) {
    return changePasswordRepo.changePassword(password, newPassword);
  }
}
