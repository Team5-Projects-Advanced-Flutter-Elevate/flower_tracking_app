import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';

import '../entity/get_data.dart';

abstract interface class GetLoggedDriverDataRepo {
  Future<ApiResult<GetDataEntity>> getLoggedDriverData();
}
