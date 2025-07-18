import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';

import '../../domain/entity/order_status.dart';

sealed class UpdateStatusState {}

class UpdateStatusInitial extends UpdateStatusState {}

class UpdateStatusLoading extends UpdateStatusState {}

class UpdateStatusSuccess extends UpdateStatusState {
  final ApiResult<OrderStatusUpdateEntity> data;

  UpdateStatusSuccess(this.data);
}

class UpdateStatusError extends UpdateStatusState {
  final String message;

  UpdateStatusError(this.message);
}
