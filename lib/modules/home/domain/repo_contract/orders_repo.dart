import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/orders_entity.dart';

abstract interface class OrdersRepo {
  Future<ApiResult<PendingOrdersEntity>> getPendingOrders({int page = 1});
}