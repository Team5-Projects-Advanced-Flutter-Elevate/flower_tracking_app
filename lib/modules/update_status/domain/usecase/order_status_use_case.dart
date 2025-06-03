import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/update_status/domain/repo/order_status_repo.dart';
import 'package:injectable/injectable.dart';

import '../entity/order_status.dart';

@injectable
class UpdateOrderStatusUseCase {
  UpdateOrderStatusRepo updateOrderStatusRepo;

  UpdateOrderStatusUseCase(this.updateOrderStatusRepo);

  Future<ApiResult<OrderStatusUpdateEntity>> call(
    String state,
    String orderId,
  ) {
    return updateOrderStatusRepo.updateStatus(state, orderId);
  }
}
