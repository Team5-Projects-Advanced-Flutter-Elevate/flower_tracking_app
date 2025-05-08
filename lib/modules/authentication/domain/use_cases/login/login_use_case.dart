import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/response/login_response_entity.dart';
import 'package:flower_tracking_app/modules/authentication/domain/repositories_contracts/login/login_repo.dart';
import 'package:injectable/injectable.dart';
import '../../entities/login/request/login_request_entity.dart';

@injectable
class LoginUseCase {
  final LoginRepo _loginRepo;

  LoginUseCase(this._loginRepo);

  Future<ApiResult<LoginResponseEntity>> call({
    required LoginRequestEntity loginRequest,
    required bool rememberMe,
  }) {
    return _loginRepo.login(loginRequest: loginRequest, rememberMe: rememberMe);
  }
}
