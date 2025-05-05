import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';

abstract interface class ApplyDataSource {
  Future<ApiResult<ApplyResponseEntity>> applyDriver(FormData formData);
}
