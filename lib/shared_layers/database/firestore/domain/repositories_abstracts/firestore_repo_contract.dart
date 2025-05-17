import '../../../../../core/apis/api_result/api_result.dart';
import '../entities/driver/driver_entity_firestore.dart';
import '../entities/order/order_entity_firestore.dart';

abstract interface class FirestoreRepoContract {
  Future<ApiResult<void>> addDriver(DriverEntityFirestore driverEntity);

  Future<ApiResult<void>> updateDriverInfo(DriverEntityFirestore driverEntity);

  Future<ApiResult<void>> addOrder({
    required String driverId,
    required OrderEntityFirestore orderEntity,
  });

  Future<ApiResult<OrderEntityFirestore>> readOrder({
    required String driverId,
    required String orderId,
  });
  Future<ApiResult<void>> updateOrder({
    required String driverId,
    required OrderEntityFirestore orderEntity,
  });
}
