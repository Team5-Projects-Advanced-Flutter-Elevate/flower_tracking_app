import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/data/api/api_client/auth_api_client.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/logged_driver_data/logged_drivr_data_remote_data_source.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/logged_driver_data/logged_driver_data_response_dto.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoggedDriverDataRemoteDataSource)
class LoggedDriverDataRemoteDataSourceImp
    implements LoggedDriverDataRemoteDataSource {
  final AuthApiClient _authApiClient;

  LoggedDriverDataRemoteDataSourceImp(this._authApiClient);

  @override
  Future<ApiResult<LoggedDriverDataResponseEntity>>
  getLoggedDriverData() async {
    var apiResult = await ApiExecutor.executeApi(
      () => _authApiClient.getLoggedDriverData(),
    );

    switch (apiResult) {
      case Success<LoggedDriverDataResponseDto>():
        return Success(data: apiResult.data.convertIntoEntity());
      case Error<LoggedDriverDataResponseDto>():
        return Error(error: apiResult.error);
    }
  }
}
