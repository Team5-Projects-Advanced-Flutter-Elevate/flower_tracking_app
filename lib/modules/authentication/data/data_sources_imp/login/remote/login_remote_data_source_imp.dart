import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/data/api/api_client/auth_api_client.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/login/remote/login_remote_data_source.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/login/request/login_request_dto.dart';
import 'package:flower_tracking_app/modules/authentication/data/models/login/response/login_response_dto.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/request/login_request_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/response/login_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImp implements LoginRemoteDataSource {
  final AuthApiClient _authApiClient;

  LoginRemoteDataSourceImp(this._authApiClient);

  @override
  Future<ApiResult<LoginResponseEntity>> login({
    required LoginRequestEntity loginRequest,
  }) async {
    var apiResult = await ApiExecutor.executeApi(
      () => _authApiClient.login(LoginRequestDto.convertIntoDto(loginRequest)),
    );
    switch (apiResult) {
      case Success<LoginResponseDto>():
        return Success(data: apiResult.data.convertIntoEntity());
      case Error<LoginResponseDto>():
        return Error(error: apiResult.error);
    }
  }
}
