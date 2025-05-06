import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/data/models/apply_response.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';

abstract interface class ApplyDataSource {
  Future<ApiResult<ApplyResponseEntity>> applyDriver(DriverRequestModel model);

  Future<ApiResult<VehicleResponseEntity>> getVehicles();
}
