import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../api_client/vehicle_api_client.dart';

@module
abstract class VehicleApiClientProvider {
  @lazySingleton
  VehicleApiClient providerApiClient(Dio dio) {
    return VehicleApiClient(dio);
  }
}
