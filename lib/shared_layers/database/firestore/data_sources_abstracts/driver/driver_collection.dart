import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/entities/driver/driver_entity.dart';
import 'package:flower_tracking_app/core/models/driver/driver_dto.dart';

abstract interface class DriverCollection {

  Future<ApiResult<void>> addDriver(DriverDto driverDto);

  Future<ApiResult<DriverEntity>> readDriver(String driverId);

  Future<ApiResult<void>> deleteDriver(String driverId);

  Future<ApiResult<void>> updateDriverInfo(DriverDto driverDto);
}
