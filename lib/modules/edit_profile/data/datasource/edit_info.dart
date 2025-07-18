import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/edit_profile/domain/entity/edit_info.dart';

abstract class EditInfoOnlineDataSource {
  Future<ApiResult<EditMyInfoEntity>> editInfo(
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  );
}
