import 'package:flower_tracking_app/modules/edit_vehicle_info/data/models/get_vehicle_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../repo_contract/vehicle_repo_contract.dart';

@injectable
class GetVehicleByIdUseCase {
  final VehicleRepo vehicleRepo;

  GetVehicleByIdUseCase(this.vehicleRepo);

  Future<ApiResult<GetVehicleResponse>> execute(String id) =>
      vehicleRepo.getVehicleById(id);
}
