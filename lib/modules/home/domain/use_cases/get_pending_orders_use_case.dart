import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/orders_entity.dart';
import 'package:flower_tracking_app/modules/home/domain/repo_contract/orders_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPendingOrdersUseCase {
  final OrdersRepo repo;

  GetPendingOrdersUseCase(this.repo);

  Future<ApiResult<PendingOrdersEntity>> execute({int page = 1}) async {
    return await repo.getPendingOrders(page: page);
  }
}
