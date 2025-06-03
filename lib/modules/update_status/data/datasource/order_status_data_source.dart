import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';

import '../../domain/entity/order_status.dart';

abstract class UpdateOrderStatusOnlineDataSource {
  Future<ApiResult<OrderStatusUpdateEntity>> updateStatus(String state,String orderId);
}
