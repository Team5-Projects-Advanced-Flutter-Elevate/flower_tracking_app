import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/data/data_sources_abstracts/driver/driver_collection.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/data/data_sources_abstracts/order/order_collection.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/driver/driver_entity_firestore.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/repositories_abstracts/firestore_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FirestoreRepoContract)
class FirestoreRepoImp implements FirestoreRepoContract {
  final DriverCollection _driverCollection;
  final OrderCollection _orderCollection;

  FirestoreRepoImp(this._driverCollection, this._orderCollection);

  @override
  Future<ApiResult<void>> addDriver(DriverEntityFirestore driverEntity) {
    return _driverCollection.addDriver(driverEntity);
  }

  @override
  Future<ApiResult<void>> updateDriverInfo(DriverEntityFirestore driverEntity) {
    return _driverCollection.updateDriverInfo(driverEntity);
  }

  @override
  Future<ApiResult<void>> addOrder({
    required String driverId,
    required OrderEntityFirestore orderEntity,
  }) {
    return _orderCollection.addOrder(
      driverId: driverId,
      orderEntity: orderEntity,
    );
  }

  @override
  Future<ApiResult<void>> updateOrder({
    required String driverId,
    required OrderEntityFirestore orderEntity,
  }) {
    return _orderCollection.updateOrder(
      driverId: driverId,
      orderEntity: orderEntity,
    );
  }

  @override
  Future<ApiResult<OrderEntityFirestore>> readOrder({
    required String driverId,
    required String orderId,
  }) {
    return _orderCollection.readOrder(driverId: driverId, orderId: orderId);
  }
}
