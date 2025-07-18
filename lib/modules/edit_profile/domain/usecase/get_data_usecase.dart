import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:injectable/injectable.dart';

import '../entity/get_data.dart';
import '../repo/get_data_repo.dart';

@injectable
class GetDriverDataUseCase {
  final GetLoggedDriverDataRepo _loggedDriverDataRepo;

  GetDriverDataUseCase(this._loggedDriverDataRepo);

  Future<ApiResult<GetDataEntity>> call() {
    return _loggedDriverDataRepo.getLoggedDriverData();
  }
}
