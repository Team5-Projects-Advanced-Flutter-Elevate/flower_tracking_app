import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';

import '../../data/models/apply_response.dart';
import '../entities/apply_response_entity.dart';

abstract interface class ApplyRepo {
  Future<ApiResult<ApplyResponseEntity>> applyDriver(DriverRequestModel model);
}