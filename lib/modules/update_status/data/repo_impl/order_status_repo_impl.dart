import 'package:flower_tracking_app/modules/update_status/data/datasource/order_status_data_source.dart';
import 'package:flower_tracking_app/modules/update_status/domain/repo/order_status_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/apis/api_result/api_result.dart';
import '../../domain/entity/order_status.dart';

@Injectable(as: UpdateOrderStatusRepo)
class UpdateOrderStatusRepoImpl implements UpdateOrderStatusRepo {
  UpdateOrderStatusOnlineDataSource updateOrderStatusOnlineDataSource;

  UpdateOrderStatusRepoImpl(this.updateOrderStatusOnlineDataSource);
  @override
  Future<ApiResult<OrderStatusUpdateEntity>> updateStatus(
    String state,
    String orderId,
  ) {
    // TODO: implement updateStatus
    return updateOrderStatusOnlineDataSource.updateStatus(state, orderId);
  }
}
