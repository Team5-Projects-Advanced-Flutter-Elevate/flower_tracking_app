import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import '../../domain/entity/get_data.dart';

abstract interface class GetLoggedDriverDataOnlineDataSource {
  Future<ApiResult<GetDataEntity>> getLoggedDriverData();
}
