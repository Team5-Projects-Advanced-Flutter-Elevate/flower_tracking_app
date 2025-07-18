import 'package:flower_tracking_app/modules/edit_vehicle_info/data/datasource_contract/vehicle_datasource.dart';
import 'package:flower_tracking_app/modules/edit_vehicle_info/data/models/edite_profile_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entities/vehicle_response_entity.dart';
import '../../domain/repo_contract/vehicle_repo_contract.dart';

@Injectable(as: VehicleRepo)
class VehicleRepoImpl implements VehicleRepo {
  VehicleDataSource vehicleDataSource;

  VehicleRepoImpl({required this.vehicleDataSource});

  @override
  Future<ApiResult<VehicleResponseEntity>> getVehicles() {
    return vehicleDataSource.getVehicles();
  }

  @override
  Future<ApiResult<EditProfileResponse>> editeVehicle(
    EditVehicleRequest model,
  ) {
    return vehicleDataSource.editeVehicle(model);
  }

  @override
  Future<ApiResult<VehicleResponseEntity>> getVehicleById(String id) {
    return vehicleDataSource.getVehicleById(id);
  }
}
