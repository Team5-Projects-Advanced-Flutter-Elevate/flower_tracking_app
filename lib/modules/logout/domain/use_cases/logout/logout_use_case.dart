import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/logout/domain/entities/logout/logout_response_entity.dart';
import 'package:flower_tracking_app/modules/logout/domain/repositories_contracts/logout/logout_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final LogoutRepo _logoutRepo;

  LogoutUseCase(this._logoutRepo);

  Future<ApiResult<LogoutResponseEntity>> call() {
    return _logoutRepo.logout();
  }
}
