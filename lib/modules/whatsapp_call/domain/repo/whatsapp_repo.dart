import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';

abstract class WhatsAppRepo{
  Future<ApiResult<void>> whatsApp(String phoneNumber);

}