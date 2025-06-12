import 'package:flower_tracking_app/modules/edit_vehicle_info/data/models/edite_profile_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../repo_contract/vehicle_repo_contract.dart';

@injectable
class EditeVehicleUseCase {
  final VehicleRepo vehicleRepo;

  EditeVehicleUseCase(this.vehicleRepo);

  Future<ApiResult<EditProfileResponse>> execute(EditVehicleRequest model) =>
      vehicleRepo.editeVehicle(model);
}
