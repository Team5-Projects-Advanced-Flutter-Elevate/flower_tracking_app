import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';

abstract class OrdersRepo {
  Future<ApiResult<PendingOrdersEntity>> getDriverOrders({
    required int page,
    required int limit,
  });
}
