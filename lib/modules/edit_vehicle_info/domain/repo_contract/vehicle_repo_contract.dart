import '../../../../core/apis/api_result/api_result.dart';
import '../entities/vehicle_response_entity.dart';

abstract interface class VehicleRepo {
  Future<ApiResult<VehicleResponseEntity>> getVehicles();
}
