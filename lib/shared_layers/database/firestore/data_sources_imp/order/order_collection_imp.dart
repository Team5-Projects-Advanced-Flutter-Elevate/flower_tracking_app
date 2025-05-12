import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flower_tracking_app/core/apis/api_executor/api_executor.dart';
import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/entities/order/order_entity.dart';
import 'package:flower_tracking_app/core/models/order/order_dto.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/constants/firestore_constants.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/data_sources_abstracts/order/order_collection.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderCollection)
class OrderCollectionImp implements OrderCollection {
  CollectionReference<OrderDto> _getOrderCollectionOfDriver(String driverId) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    return db
        .collection(FirestoreConstants.driversCollection)
        .doc(driverId)
        .collection(FirestoreConstants.ordersCollection)
        .withConverter(
          fromFirestore: (snapshot, options) {
            return OrderDto.fromJson(snapshot.data());
          },
          toFirestore: (orderDto, options) {
            return orderDto.toJson();
          },
        );
  }

  @override
  Future<ApiResult<void>> addOrder({
    required String driverId,
    required OrderEntity orderEntity,
  }) {
    return ApiExecutor.executeApi(
      () => _getOrderCollectionOfDriver(
        driverId,
      ).doc(orderEntity.id).set(OrderDto.convertIntoDto(orderEntity)),
    );
  }

  @override
  Future<ApiResult<OrderEntity>> readOrder({
    required String driverId,
    required String orderId,
  }) async {
    var result = await ApiExecutor.executeApi(
      () => _getOrderCollectionOfDriver(driverId).doc(orderId).get(),
    );
    switch (result) {
      case Success<DocumentSnapshot<OrderDto>>():
        return Success(
          data: result.data.data()?.convertIntoEntity() ?? OrderEntity(),
        );
      case Error<DocumentSnapshot<OrderDto>>():
        return Error(error: result.error);
    }
  }

  @override
  Future<ApiResult<void>> updateOrder({
    required String driverId,
    required OrderEntity orderEntity,
  }) {
    return ApiExecutor.executeApi(
      () => _getOrderCollectionOfDriver(driverId)
          .doc(orderEntity.id)
          .update(OrderDto.convertIntoDto(orderEntity).toJson()),
    );
  }

  @override
  Future<ApiResult<void>> deleteOrder({
    required String driverId,
    required String orderId,
  }) {
    return ApiExecutor.executeApi(
      () => _getOrderCollectionOfDriver(driverId).doc(orderId).delete(),
    );
  }
}
