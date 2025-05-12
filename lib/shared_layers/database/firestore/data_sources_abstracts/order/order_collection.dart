import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/entities/order/order_entity.dart';

abstract interface class OrderCollection {
  Future<ApiResult<void>> addOrder({
    required String driverId,
    required OrderEntity orderEntity,
  });

  Future<ApiResult<OrderEntity>> readOrder({
    required String driverId,
    required String orderId,
  });

  Future<ApiResult<void>> updateOrder({
    required String driverId,
    required OrderEntity orderEntity,
  });
  Future<ApiResult<void>> deleteOrder({
    required String driverId,
    required String orderId,
  });
}
