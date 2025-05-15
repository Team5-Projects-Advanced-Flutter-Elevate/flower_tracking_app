import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_tracking_app/modules/home/data/models/orders_client_model.dart'
    as orders_api;

@module
abstract class OrdersApiClientProvider {
  @lazySingleton
  orders_api.OrdersApiClient providerApiClient(Dio dio) {
    return orders_api.OrdersApiClient(dio);
  }
}
