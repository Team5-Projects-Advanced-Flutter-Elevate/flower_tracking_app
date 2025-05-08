import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';

import '../../data/models/apply_response.dart';
import '../entities/apply_response_entity.dart';
import '../entities/vehicle_response_entity.dart';

abstract interface class ApplyRepo {
  Future<ApiResult<ApplyResponseEntity>> applyDriver(DriverRequestModel model);

  Future<ApiResult<VehicleResponseEntity>> getVehicles();
}
