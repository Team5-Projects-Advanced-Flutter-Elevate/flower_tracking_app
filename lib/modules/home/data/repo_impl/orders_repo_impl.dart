import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/data/models/orders_client_model.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/orders_entity.dart';
import 'package:flower_tracking_app/modules/home/domain/repo_contract/orders_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepo)
class OrdersRepoImpl implements OrdersRepo {
  final OrdersApiClient apiClient;

  OrdersRepoImpl({required this.apiClient});

  Future<ApiResult<PendingOrdersEntity>> getPendingOrders({
    int page = 1,
  }) async {
    try {
      final response = await apiClient.getPendingOrders(page: page);
      return Success(data: PendingOrdersEntity.fromResponse(response));
    } catch (e) {
      if (e is DioException) {
        return Error(
          error: Exception(
            'API error: ${e.message}, response: ${e.response?.data}',
          ),
        );
      }
      return Error(error: Exception('Unknown error: $e'));
    }
  }
}
