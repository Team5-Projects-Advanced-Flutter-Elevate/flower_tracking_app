import '../../../../core/apis/api_result/api_result.dart';
import '../../data/models/edite_profile_response.dart';
import '../../data/models/get_vehicle_response.dart';
import '../entities/vehicle_response_entity.dart';

abstract interface class VehicleRepo {
  Future<ApiResult<VehicleResponseEntity>> getVehicles();

  Future<ApiResult<EditProfileResponse>> editeVehicle(EditVehicleRequest model);

  Future<ApiResult<GetVehicleResponse>> getVehicleById(String id);
}
