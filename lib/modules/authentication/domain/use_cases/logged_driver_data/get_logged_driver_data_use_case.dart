import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/repositories_contracts/logged_driver_data/logged_driver_data_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLoggedDriverDataUseCase {
  final LoggedDriverDataRepo _loggedDriverDataRepo;

  GetLoggedDriverDataUseCase(this._loggedDriverDataRepo);

  Future<ApiResult<LoggedDriverDataResponseEntity>> call() {
    return _loggedDriverDataRepo.getLoggedDriverData();
  }
}
