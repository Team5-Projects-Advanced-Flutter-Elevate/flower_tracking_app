import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entities/vehicle_response_entity.dart';

abstract interface class VehicleDataSource {
  Future<ApiResult<VehicleResponseEntity>> getVehicles();
}

abstract class ImagePickerService {
  Future<File?> pickImage(ImageSource source);
}
