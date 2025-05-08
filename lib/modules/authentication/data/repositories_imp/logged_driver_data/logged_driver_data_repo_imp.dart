import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/data/data_sources_contracts/logged_driver_data/logged_drivr_data_remote_data_source.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/repositories_contracts/logged_driver_data/logged_driver_data_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoggedDriverDataRepo)
class LoggedDriverDataRepoImp implements LoggedDriverDataRepo {
  final LoggedDriverDataRemoteDataSource _loggedDriverDataRemoteDataSource;

  LoggedDriverDataRepoImp(this._loggedDriverDataRemoteDataSource);

  @override
  Future<ApiResult<LoggedDriverDataResponseEntity>> getLoggedDriverData() {
    return _loggedDriverDataRemoteDataSource.getLoggedDriverData();
  }
}
