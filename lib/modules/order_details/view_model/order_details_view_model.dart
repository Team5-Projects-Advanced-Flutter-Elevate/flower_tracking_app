import 'package:flower_tracking_app/core/apis/api_result/api_result.dart';
import 'package:flower_tracking_app/core/utilities/extensions/date_time_extension/date_time_extension.dart';
import 'package:flower_tracking_app/modules/order_details/view_model/order_details_state.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/repositories_abstracts/firestore_repo_contract.dart';
import 'package:flower_tracking_app/shared_layers/storage/constants/storage_constants.dart';
import 'package:flower_tracking_app/shared_layers/storage/contracts/flutter_secure_storage_service_contract.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

enum NextOrderStatusAttribute {
  receivedUserOrderAt,
  preparedUserOrderAt,
  outForDeliveryAt,
  deliveredAt,
}

@injectable
class OrderDetailsViewModel extends Cubit<OrderDetailsState> {
  final FirestoreRepoContract _firestoreRepoContract;
  final SecureStorageService _secureStorageService;

  OrderDetailsViewModel(this._firestoreRepoContract, this._secureStorageService)
    : super(const OrderDetailsState());

  void doIntent(OrderDetailsIntent intent) {
    switch (intent) {
      case ReadOrderInfo():
        _readOrderInfo(driverId: intent.driverId, orderId: intent.orderId);
        break;
      case OnOrderStatusButtonClick():
        _onOrderStatusButtonClick(intent.driverId, intent.orderId);
        break;
    }
  }

  void _readOrderInfo({
    required String driverId,
    required String orderId,
  }) async {
    emit(const OrderDetailsState(orderStatus: Status.loading));
    var result = await _firestoreRepoContract.readOrder(
      driverId: driverId,
      orderId: orderId,
    );
    switch (result) {
      case Success<OrderEntityFirestore>():
        _calculatedSelectedIndex(result.data);
        emit(
          OrderDetailsState(
            orderStatus: Status.success,
            orderEntityFirestore: result.data,
          ),
        );
      case Error<OrderEntityFirestore>():
        emit(OrderDetailsState(orderStatus: Status.error, error: result.error));
    }
  }

  int selectedIndex = 0;

  void _calculatedSelectedIndex(OrderEntityFirestore orderEntity) {
    if (orderEntity.receivedUserOrderAt != null) selectedIndex++;
    if (orderEntity.preparedUserOrderAt != null) selectedIndex++;
    if (orderEntity.outForDeliveryAt != null) selectedIndex++;
    if (orderEntity.deliveredAt != null) selectedIndex++;
  }

  int? receivedUserOrderAt;

  void _onOrderStatusButtonClick(String driverId, String orderId) async {
    // List<NextOrderStatusAttribute> attributesList =
    //     NextOrderStatusAttribute.values;
    emit(state.copyWith(updateOrderStateStatus: Status.loading));
    late ApiResult<void> result;
    switch (selectedIndex) {
      case 0:
        receivedUserOrderAt = DateTime.now().dateSinceEpoch();
        result = await _firestoreRepoContract.updateOrder(
          driverId: driverId,
          orderEntity: OrderEntityFirestore(
            id: orderId,
            receivedUserOrderAt: receivedUserOrderAt,
          ),
        );
        break;
      case 1:
        result = await _firestoreRepoContract.updateOrder(
          driverId: driverId,
          orderEntity: OrderEntityFirestore(
            id: orderId,
            preparedUserOrderAt: DateTime.now().dateSinceEpoch(),
          ),
        );
        break;
      case 2:
        result = await _firestoreRepoContract.updateOrder(
          driverId: driverId,
          orderEntity: OrderEntityFirestore(
            id: orderId,
            outForDeliveryAt: DateTime.now().dateSinceEpoch(),
          ),
        );
      case 3:
        result = await _firestoreRepoContract.updateOrder(
          driverId: driverId,
          orderEntity: OrderEntityFirestore(
            id: orderId,
            isDelivered: true,
            deliveredAt: DateTime.now().dateSinceEpoch(),
          ),
        );
        break;
    }
    switch (result) {
      case Success<void>():
        selectedIndex++;
        if (selectedIndex == 4) {
          await _secureStorageService.deleteValue(
            StorageConstants.currentAcceptedOrderId,
          );
        }
        Future.delayed(const Duration(milliseconds: 300), () {
          emit(state.copyWith(updateOrderStateStatus: Status.success));
        });
      case Error<void>():
        Future.delayed(const Duration(milliseconds: 300), () {
          emit(state.copyWith(updateOrderStateStatus: Status.error));
        });
    }
    Future.delayed(const Duration(seconds: 2), () {
      emit(state.copyWith(updateOrderStateStatus: Status.idle));
    });
  }
}

sealed class OrderDetailsIntent {}

class ReadOrderInfo extends OrderDetailsIntent {
  String driverId;
  String orderId;

  ReadOrderInfo({required this.driverId, required this.orderId});
}

class OnOrderStatusButtonClick extends OrderDetailsIntent {
  String driverId;
  String orderId;
  int buttonIndex;

  OnOrderStatusButtonClick({
    required this.driverId,
    required this.orderId,
    required this.buttonIndex,
  });
}
