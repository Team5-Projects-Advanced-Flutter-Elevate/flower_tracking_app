import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/models/directions_request/directions_resquest_dto.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/models/directions_response/directions_response_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'location_map_api_client.g.dart';

@RestApi()
abstract class LocationMapApiClient {
  factory LocationMapApiClient(Dio dio, {required String baseUrl}) =
      _LocationMapApiClient;

  @POST(ApisEndpoints.directionsEndPoint)
  Future<DirectionsResponseDto> getDirections(
    @Header('Authorization') String authorization,
    @Body() DirectionsRequestDto directionsRequest,
  );
}
