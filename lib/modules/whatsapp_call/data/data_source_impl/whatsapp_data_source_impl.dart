import 'package:flower_tracking_app/modules/whatsapp_call/data/data_source/whatsapp_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';
import 'package:url_launcher/url_launcher.dart';

@Injectable(as: WhatsAppDataSource)
class WhatsAppDataSourceImpl implements WhatsAppDataSource {
  @override
  Future<ApiResult<void>> whatsApp(String phoneNumber) async {
    // TODO: implement whatsApp
    var result = await ApiExecutor.executeApi(() async {
      final url = Uri.parse('https://wa.me/$phoneNumber');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch WhatsApp');
      }
    });

    switch (result) {
      case Success<void>():
        return Success(data: 'WhatsAppLaunched');
      case Error<void>():
        return Error(error: 'Could not launch WhatsApp');
    }
  }
}
