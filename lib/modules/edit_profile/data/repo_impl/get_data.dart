import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entity/get_data.dart';
import '../../domain/repo/get_data_repo.dart';
import '../datasource/get_data.dart';

@Injectable(as: GetLoggedDriverDataRepo)
class LoggedDriverDataRepoImp implements GetLoggedDriverDataRepo {
  final GetLoggedDriverDataOnlineDataSource _loggedDriverDataRemoteDataSource;

  LoggedDriverDataRepoImp(this._loggedDriverDataRemoteDataSource);

  @override
  Future<ApiResult<GetDataEntity>> getLoggedDriverData() {
    // TODO: implement getLoggedDriverData
    return _loggedDriverDataRemoteDataSource.getLoggedDriverData();
  }
}
