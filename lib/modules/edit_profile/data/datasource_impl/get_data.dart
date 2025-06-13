import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/get_data.dart';
import '../api/api_client/get_data_api_client.dart';
import '../datasource/get_data.dart';
import '../model/get_data.dart';

@Injectable(as: GetLoggedDriverDataOnlineDataSource)
class GetLoggedDriverDataOnlineDataSourceImpl
    implements GetLoggedDriverDataOnlineDataSource {
  final GetDataApiClient _authApiClient;

  GetLoggedDriverDataOnlineDataSourceImpl(this._authApiClient);

  @override
  Future<ApiResult<GetDataEntity>> getLoggedDriverData() async {
    var apiResult = await ApiExecutor.executeApi(
      () => _authApiClient.getLoggedDriverData(),
    );

    switch (apiResult) {
      case Success<GetData>():
        return Success(data: apiResult.data.toEntity());
      case Error<GetData>():
        return Error(error: apiResult.error);
    }
  }
}
