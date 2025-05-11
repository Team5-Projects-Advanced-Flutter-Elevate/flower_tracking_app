import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/logged_driver_data/logged_drivr_data_remote_data_source.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/login/local/login_local_data_source.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/login/remote/login_remote_data_source.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/request/login_request_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/response/login_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/repositories_contracts/login/login_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utilities/dio/dio_service/dio_service.dart';

@Injectable(as: LoginRepo)
class LoginRepoImp implements LoginRepo {
  final LoginRemoteDataSource _loginRemoteDataSource;
  final LoginLocalDataSource _loginLocalDataSource;
  final LoggedDriverDataRemoteDataSource _loggedDriverDataRemoteDataSource;

  LoginRepoImp(
    this._loginRemoteDataSource,
    this._loginLocalDataSource,
    this._loggedDriverDataRemoteDataSource,
  );

  @override
  Future<ApiResult<LoginResponseEntity>> login({
    required LoginRequestEntity loginRequest,
    required bool rememberMe,
  }) async {
    var dataSourceResult = await _loginRemoteDataSource.login(
      loginRequest: loginRequest,
    );
    switch (dataSourceResult) {
      case Success<LoginResponseEntity>():
        DioServiceExtension.updateDioWithToken(
          dataSourceResult.data.token ?? "",
        );
        var loggedDriverDataResult =
            await _loggedDriverDataRemoteDataSource.getLoggedDriverData();
        switch (loggedDriverDataResult) {
          case Success<LoggedDriverDataResponseEntity>():
            loggedDriverDataResult.data.token = dataSourceResult.data.token;
            _loginLocalDataSource.saveDriverData(
              loggedDriverDataResponseEntity: loggedDriverDataResult.data,
            );
            _loginLocalDataSource.saveRememberMeValue(rememberMe: rememberMe);
            return Success(data: dataSourceResult.data);
          case Error<LoggedDriverDataResponseEntity>():
            return Error(error: loggedDriverDataResult.error);
        }
      case Error<LoginResponseEntity>():
        return Error(error: dataSourceResult.error);
    }
  }
}
