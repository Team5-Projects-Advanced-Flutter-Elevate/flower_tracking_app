import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_response/directions_response_entity.dart';

import '../../../domain/entities/directions_request/directions_request_entity.dart';

abstract interface class LocationMapRemoteDataSource {
  Future<ApiResult<DirectionsResponseEntity>> getDirection({
    required DirectionsRequestEntity directionRequestEntity,
  });
}
