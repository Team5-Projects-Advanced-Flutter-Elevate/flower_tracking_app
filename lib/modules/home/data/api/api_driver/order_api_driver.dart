import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_tracking_app/modules/home/data/models/driver/pending_orders_model.dart'
    as orders_api;

@module
abstract class OrdersApiDriverProvider {
  @lazySingleton
  orders_api.OrdersRemoteDataSource providerApiClient(Dio dio) {
    return orders_api.OrdersRemoteDataSource(dio);
  }
}
