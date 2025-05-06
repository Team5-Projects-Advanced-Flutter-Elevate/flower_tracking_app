import 'package:dio/dio.dart' hide DioMediaType;
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';

import '../../models/vehicle_response.dart';

class ApplyApiClient {
  final Dio _dio;

  ApplyApiClient(this._dio);

  Future<ApplyResponse> applyDriver(DriverRequestModel model) async {
    final formData = await model.toFormData();

    final response = await _dio.post(ApisEndpoints.applyDriver, data: formData);

    return ApplyResponse.fromJson(response.data);
  }

  Future<VehicleResponse> getVehicles() async {
    final response = await _dio.get(ApisEndpoints.getVehicles);
    return VehicleResponse.fromJson(response.data);
  }
}
