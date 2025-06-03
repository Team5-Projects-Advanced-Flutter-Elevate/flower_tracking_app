import 'package:dio/dio.dart' hide DioMediaType;
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';

import '../../models/vehicle_response.dart';

class VehicleApiClient {
  final Dio _dio;

  VehicleApiClient(this._dio);

  Future<VehicleResponse> getVehicles() async {
    final response = await _dio.get(ApisEndpoints.getVehicles);
    return VehicleResponse.fromJson(response.data);
  }
}
