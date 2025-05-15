import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';

abstract class CallRepo {
  Future<ApiResult<void>> call(String phoneNumber);
}
