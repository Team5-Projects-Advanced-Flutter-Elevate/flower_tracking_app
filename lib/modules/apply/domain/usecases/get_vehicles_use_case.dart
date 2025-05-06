import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/repo_contract/apply_repo_contract.dart';
import 'package:injectable/injectable.dart';


@injectable
class GetVehiclesUseCase {
  final ApplyRepo applyRepo;

  GetVehiclesUseCase(this.applyRepo);

  Future<ApiResult<VehicleResponseEntity>> execute() => applyRepo.getVehicles();
}
