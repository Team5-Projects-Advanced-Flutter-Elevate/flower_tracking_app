import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/order_status.dart';

part 'status_api_client.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class StateApiClient {
  factory StateApiClient(Dio dio) = _StateApiClient;

  @PUT('${ApisEndpoints.updateOrderState}/{orderId}')
  Future<OrderStatusUpdate> updateState(
    @Path('orderId') String orderId,
    @Body() Map<String, dynamic> body,
  );
}
