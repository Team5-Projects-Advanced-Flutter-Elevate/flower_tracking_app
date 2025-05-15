import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/whatsapp_call/domain/repo/call_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CallUseCase {
  CallRepo callRepo;
  CallUseCase(this.callRepo);

  Future<ApiResult<void>> call(String phoneNumber) {
    return callRepo.call(phoneNumber);
  }
}
