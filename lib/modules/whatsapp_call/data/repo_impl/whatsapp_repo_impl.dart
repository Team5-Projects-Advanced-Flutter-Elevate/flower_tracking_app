import 'package:flower_tracking_app/modules/whatsapp_call/data/data_source/whatsapp_data_source.dart';
import 'package:flower_tracking_app/modules/whatsapp_call/domain/repo/whatsapp_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';

@Injectable(as: WhatsAppRepo)
class WhatsAppRepoImpl implements WhatsAppRepo {
  WhatsAppDataSource whatsAppDataSource;
  WhatsAppRepoImpl(this.whatsAppDataSource);
  @override
  Future<ApiResult<void>> whatsApp(String phoneNumber) {
    // TODO: implement whatsApp
    return whatsAppDataSource.whatsApp(phoneNumber);
  }
}
