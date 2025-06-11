import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/logout/data/api/api_client/logout_api_client.dart';
import 'package:flower_tracking_app/modules/logout/data/data_sources_contracts/logout/logout_remote_data_source.dart';
import 'package:flower_tracking_app/modules/logout/data/models/logout/logout_response_dto.dart';
import 'package:flower_tracking_app/modules/logout/domain/entities/logout/logout_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRemoteDataSource)
class LogoutRemoteDataSourceImp implements LogoutRemoteDataSource {
  final LogoutApiClient _logoutApiClient;

  LogoutRemoteDataSourceImp(this._logoutApiClient);

  @override
  Future<ApiResult<LogoutResponseEntity>> logout() async {
    var result = await ApiExecutor.executeApi(() => _logoutApiClient.logout());
    switch (result) {
      case Success<LogoutResponseDto>():
        return Success(data: result.data.convertIntoEntity());
      case Error<LogoutResponseDto>():
        return Error(error: result.error);
    }
  }
}
