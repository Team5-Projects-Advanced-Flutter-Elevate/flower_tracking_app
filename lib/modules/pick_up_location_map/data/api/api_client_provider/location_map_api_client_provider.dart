import 'package:dio/dio.dart';
import 'package:flower_tracking_app/modules/pick_up_location_map/data/api/api_client/location_map_api_client.dart';
import 'package:injectable/injectable.dart';

@module
abstract class LocationMapApiClientProvider {
  @singleton
  LocationMapApiClient provideApiClient(Dio dio) {
    return LocationMapApiClient(dio);
  }
}
