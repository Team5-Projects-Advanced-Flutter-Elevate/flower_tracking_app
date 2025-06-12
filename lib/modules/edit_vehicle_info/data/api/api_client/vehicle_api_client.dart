import 'package:dio/dio.dart' hide DioMediaType;
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/edit_vehicle_info/data/models/edite_profile_response.dart';

import '../../models/get_vehicle_response.dart';
import '../../models/vehicle_response.dart';

class VehicleApiClient {
  final Dio _dio;

  VehicleApiClient(this._dio);

  Future<VehicleResponse> getVehicles() async {
    final response = await _dio.get(ApisEndpoints.getVehicles);
    return VehicleResponse.fromJson(response.data);
  }

  Future<GetVehicleResponse> getVehicleById({required String id}) async {
    final response = await _dio.get("${ApisEndpoints.getVehicles}/$id");
    return GetVehicleResponse.fromJson(response.data);
  }

  Future<EditProfileResponse> editVehicleInfo(EditVehicleRequest model) async {
    final formData = await model.toFormData();

    final response = await _dio.put(ApisEndpoints.editProfile, data: formData);

    return EditProfileResponse.fromJson(response.data);
  }
}
