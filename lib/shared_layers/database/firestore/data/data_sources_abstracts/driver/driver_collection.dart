import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/driver/driver_entity_firestore.dart';

abstract interface class DriverCollection {
  Future<ApiResult<void>> addDriver(DriverEntityFirestore driverEntity);

  Future<ApiResult<DriverEntityFirestore>> readDriver(String driverId);

  Future<ApiResult<void>> deleteDriver(String driverId);

  Future<ApiResult<void>> updateDriverInfo(DriverEntityFirestore driverEntity);
}
