import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/entity/edit_info.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/repo/edit_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditInfoUseCase {
  final EditInfoRepo _editInfoRepo;
  EditInfoUseCase(this._editInfoRepo);

  Future<ApiResult<EditMyInfoEntity>> call(
    String? firstName,
    String? lastName,
    String? email,
    String? phone,

  ) {
    return _editInfoRepo.editInfo(
      firstName,
      lastName,
      email,
      phone,

    );
  }
}
