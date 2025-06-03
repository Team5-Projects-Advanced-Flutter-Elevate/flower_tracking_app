import 'package:flower_tracking_app/modules/edit_vehicle_info/data/datasource_contract/vehicle_datasource.dart';
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
}
