import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_tracking_app/modules/home/data/models/orders_client_model.dart'
    as ordersApi;

@module
abstract class OrdersApiClientProvider {
  @lazySingleton
  ordersApi.OrdersApiClient providerApiClient(Dio dio) {
    return ordersApi.OrdersApiClient(dio);
  }
}
