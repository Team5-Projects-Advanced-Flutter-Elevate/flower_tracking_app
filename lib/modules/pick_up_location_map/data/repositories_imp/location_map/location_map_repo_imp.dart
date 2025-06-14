import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/data_sources_contracts/location_map/location_map_remote_data_source.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_request/directions_request_entity.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_response/directions_response_entity.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/repositories_contracts/location_map/location_map_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocationMapRepo)
class LocationMapRepoImp implements LocationMapRepo {
  final LocationMapRemoteDataSource _locationMapRemoteDataSource;

  LocationMapRepoImp(this._locationMapRemoteDataSource);

  @override
  Future<ApiResult<DirectionsResponseEntity>> getDirection({
    required DirectionsRequestEntity directionRequestEntity,
  }) {
    return _locationMapRemoteDataSource.getDirection(
      directionRequestEntity: directionRequestEntity,
    );
  }
}
