import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/api/api_client/location_map_api_client.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/api/constants/location_map_api_constants.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/data_sources_contracts/location_map/location_map_remote_data_source.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/models/directions_request/directions_resquest_dto.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/models/directions_response/directions_response_dto.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_request/directions_request_entity.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_response/directions_response_entity.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/di/injectable_initializer.dart';
import '../../../../../core/utilities/dio/dio_service/dio_service.dart';

@Injectable(as: LocationMapRemoteDataSource)
class LocationMapRemoteDataSourceImp implements LocationMapRemoteDataSource {
  final LocationMapApiClient _locationMapApiClient;

  LocationMapRemoteDataSourceImp(this._locationMapApiClient);

  @override
  Future<ApiResult<DirectionsResponseEntity>> getDirection({
    required DirectionsRequestEntity directionRequestEntity,
  }) async {
    final String authorization =
        getIt.get<Dio>().options.headers["Authorization"];
    final String token = authorization.split(' ').toList()[1].trim();
    DioServiceExtension.clearDefaultHeaders();
    var result = await ApiExecutor.executeApi(
      () => _locationMapApiClient.getDirections(
        LocationMapApiConstants.orsApiKey,
        DirectionsRequestDto.convertIntoDto(directionRequestEntity).toJson(),
      ),
    );
    DioServiceExtension.setHeadersToDefault(token);
    switch (result) {
      case Success<DirectionsResponseDto>():
        return Success(data: result.data.convertIntoEntity());
      case Error<DirectionsResponseDto>():
        return Error(error: result.error);
    }
  }
}
