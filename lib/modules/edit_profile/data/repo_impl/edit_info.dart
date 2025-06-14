import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/edit_profile/data/datasource/edit_info.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/repo/edit_data.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/edit_info.dart';

@Injectable(as: EditInfoRepo)
class EditInfoRepoImpl implements EditInfoRepo {
  final EditInfoOnlineDataSource _editInfoOnlineDataSource;
  EditInfoRepoImpl(this._editInfoOnlineDataSource);
  @override
  Future<ApiResult<EditMyInfoEntity>> editInfo(
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  ) {
    return _editInfoOnlineDataSource.editInfo(
      firstName,
      lastName,
      email,
      phone,
    );
  }
}
