import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_tracking_app/modules/home/data/models/driver/pending_orders_model.dart'
    as ordersApi;

@module
abstract class OrdersApiDriverProvider {
  @lazySingleton
  ordersApi.OrdersRemoteDataSource providerApiClient(Dio dio) {
    return ordersApi.OrdersRemoteDataSource(dio);
  }
}
