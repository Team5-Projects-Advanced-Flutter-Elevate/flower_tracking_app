import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';
import 'package:flower_tracking_app/modules/home/domain/repo_contract/driver/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPendingOrdersUseCase {
  final OrdersRepo repository;

  GetPendingOrdersUseCase(this.repository);

  Future<ApiResult<PendingOrdersEntity>> execute({required int page}) async {
    return await repository.getDriverOrders(page: page, limit: 10);
  }
}
