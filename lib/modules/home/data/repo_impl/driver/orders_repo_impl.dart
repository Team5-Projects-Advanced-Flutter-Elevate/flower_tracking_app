import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/modules/home/data/models/driver/pending_orders_model.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';
import 'package:flower_tracking_app/modules/home/domain/repo_contract/driver/orders_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrdersRepo)
class OrdersRepositoryImpl implements OrdersRepo {
  final OrdersRemoteDataSource remoteDataSource;

  OrdersRepositoryImpl(this.remoteDataSource);

  @override
  Future<ApiResult<PendingOrdersEntity>> getDriverOrders({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await remoteDataSource.getDriverOrders(limit, page);
      return Success(data: response.toEntity());
    } catch (e) {
      if (e is DioException) {
        return Error(error: e.message ?? 'Failed to fetch orders');
      }
      return Error(error: e.toString());
    }
  }
}
