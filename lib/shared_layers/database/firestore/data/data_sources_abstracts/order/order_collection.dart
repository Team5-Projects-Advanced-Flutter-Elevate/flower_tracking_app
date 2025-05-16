import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import '../../../domain/entities/order/order_entity_firestore.dart';

abstract interface class OrderCollection {
  Future<ApiResult<void>> addOrder({
    required String driverId,
    required OrderEntityFirestore orderEntity,
  });

  Future<ApiResult<OrderEntityFirestore>> readOrder({
    required String driverId,
    required String orderId,
  });

  Future<ApiResult<void>> updateOrder({
    required String driverId,
    required OrderEntityFirestore orderEntity,
  });
  Future<ApiResult<void>> deleteOrder({
    required String driverId,
    required String orderId,
  });
}
