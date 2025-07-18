import 'package:flower_tracking_app/modules/edit_profile/data/datasource/edit_info.dart';
import 'package:flower_tracking_app/modules/edit_profile/data/model/edit_info.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/edit_info.dart';
import '../api/api_client/get_data_api_client.dart';

@Injectable(as: EditInfoOnlineDataSource)
class EditInfoOnlineDataSourceImpl implements EditInfoOnlineDataSource {
  final GetDataApiClient _getDataApiClient;
  EditInfoOnlineDataSourceImpl(this._getDataApiClient);
  @override
  Future<ApiResult<EditMyInfoEntity>> editInfo(
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  ) async {
    var apiResult = await ApiExecutor.executeApi(
      () => _getDataApiClient.editInfo({
        "firstName": "$firstName",
        "lastName": "$lastName",
        "email": "$email",
        "phone": "$phone",
      }),
    );

    switch (apiResult) {
      case Success<EditMyInfo>():
        return Success(data: apiResult.data.toEntity());
      case Error<EditMyInfo>():
        return Error(error: apiResult.error);
    }
  }
}
