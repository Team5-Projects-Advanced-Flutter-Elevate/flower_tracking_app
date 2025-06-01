import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/logout/data/data_sources_contracts/logout/logout_remote_data_source.dart';
import 'package:flower_tracking_app/modules/logout/domain/entities/logout/logout_response_entity.dart';
import 'package:flower_tracking_app/modules/logout/domain/repositories_contracts/logout/logout_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepo)
class LogoutRepoImp implements LogoutRepo {
  final LogoutRemoteDataSource _logoutRemoteDataSource;

  LogoutRepoImp(this._logoutRemoteDataSource);

  @override
  Future<ApiResult<LogoutResponseEntity>> logout() {
    return _logoutRemoteDataSource.logout();
  }
}
