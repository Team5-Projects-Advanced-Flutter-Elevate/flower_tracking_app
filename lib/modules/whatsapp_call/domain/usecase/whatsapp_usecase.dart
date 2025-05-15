import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/whatsapp_call/domain/repo/whatsapp_repo.dart';
import 'package:injectable/injectable.dart';
@injectable
class WhatsAppUseCase {
  WhatsAppRepo whatsAppRepo;
  WhatsAppUseCase(this.whatsAppRepo);
  Future<ApiResult<void>> whatsApp(String phoneNumber) {
    return whatsAppRepo.whatsApp(phoneNumber);
  }
}
