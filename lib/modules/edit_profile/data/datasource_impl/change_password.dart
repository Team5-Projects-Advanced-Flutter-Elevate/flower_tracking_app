import 'package:flower_tracking_app/modules/edit_profile/data/datasource/change_password.dart';
import 'package:flower_tracking_app/modules/edit_profile/data/model/change_password.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/change_password.dart';
import '../api/api_client/get_data_api_client.dart';

@Injectable(as: ChangePasswordOnlineDataSource)
class ChangePasswordOnlineDataSourceImpl
    implements ChangePasswordOnlineDataSource {
  final GetDataApiClient _getDataApiClient;
  ChangePasswordOnlineDataSourceImpl(this._getDataApiClient);

  @override
  Future<ApiResult<ChangePasswordEntity>> changePassword(
    String? password,
    String? newPassword,
  ) async {
    var apiResult = await ApiExecutor.executeApi(
      () => _getDataApiClient.changePassword({
        "password": "$password",
        "newPassword": "$newPassword",
      }),
    );

    switch (apiResult) {
      case Success<ChangePasswordModel>():
        return Success(data: apiResult.data.toEntity());
      case Error<ChangePasswordModel>():
        return Error(error: apiResult.error);
    }
  }
}
