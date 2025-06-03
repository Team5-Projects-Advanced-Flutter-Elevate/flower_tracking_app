import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_response/directions_response_entity.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/repositories_contracts/location_map/location_map_repo.dart';
import 'package:injectable/injectable.dart';

import '../../entities/directions_request/directions_request_entity.dart';

@injectable
class GetDirectionsUseCase {
  final LocationMapRepo _locationMapRepo;

  GetDirectionsUseCase(this._locationMapRepo);

  Future<ApiResult<DirectionsResponseEntity>> call({
    required DirectionsRequestEntity directionRequestEntity,
  }) {
    return _locationMapRepo.getDirection(
      directionRequestEntity: directionRequestEntity,
    );
  }
}
