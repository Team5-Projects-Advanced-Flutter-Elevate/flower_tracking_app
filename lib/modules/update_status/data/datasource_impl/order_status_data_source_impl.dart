import 'package:flower_tracking_app/modules/update_status/data/datasource/order_status_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_executor/api_executor.dart';
import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/order_status.dart';
import '../api/api_client/status_api_client.dart';
import '../model/order_status.dart';

@Injectable(as: UpdateOrderStatusOnlineDataSource)
class UpdateOrderStatusOnlineDataSourceImpl
    implements UpdateOrderStatusOnlineDataSource {
  final StateApiClient _stateApiClient;

  UpdateOrderStatusOnlineDataSourceImpl(this._stateApiClient);

  @override
  Future<ApiResult<OrderStatusUpdateEntity>> updateStatus(
    String state,
    String orderId,
  ) async {
    var result = await ApiExecutor.executeApi(() async {
      var response = await _stateApiClient.updateState(orderId, {
        'state': state,
      });
      return response;
    });
    switch (result) {
      case Success<OrderStatusUpdate>():
        return Success(data: result.data.toEntity());
      case Error<OrderStatusUpdate?>():
        return Error(error: result.toString());
    }
  }
}
