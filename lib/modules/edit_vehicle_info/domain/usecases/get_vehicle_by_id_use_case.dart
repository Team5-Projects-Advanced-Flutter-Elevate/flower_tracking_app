import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../entities/vehicle_response_entity.dart';
import '../repo_contract/vehicle_repo_contract.dart';

@injectable
class GetVehicleByIdUseCase {
  final VehicleRepo vehicleRepo;

  GetVehicleByIdUseCase(this.vehicleRepo);

  Future<ApiResult<VehicleResponseEntity>> execute(String id) =>
      vehicleRepo.getVehicleById(id);
}
