import 'dart:io';

import 'package:flower_tracking_app/modules/edit_vehicle_info/data/models/edite_profile_response.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entities/vehicle_response_entity.dart';
import '../models/get_vehicle_response.dart';

abstract interface class VehicleDataSource {
  Future<ApiResult<VehicleResponseEntity>> getVehicles();

  Future<ApiResult<GetVehicleResponse>> getVehicleById(String id);

  Future<ApiResult<EditProfileResponse>> editeVehicle(EditVehicleRequest model);
}

abstract class ImagePickerService {
  Future<File?> pickImage(ImageSource source);
}
