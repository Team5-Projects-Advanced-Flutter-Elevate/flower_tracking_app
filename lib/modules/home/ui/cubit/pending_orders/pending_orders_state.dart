import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/orders_entity.dart';

import '../../../../../shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';

enum Status { initial, loading, success, error, loadingMore }

class OrdersState extends Equatable {
  final Status loadOrdersStatus;
  final PendingOrdersEntity? orders;
  final Status addingOrderToFirestore;
  final int? pressedAcceptOfOrderIndex;
  final String? addedOrderIdToFirestore;
  final Object? error;
  final int currentPage;

  const OrdersState({
    this.loadOrdersStatus = Status.initial,
    this.addingOrderToFirestore = Status.initial,
    this.pressedAcceptOfOrderIndex,
    this.addedOrderIdToFirestore,
    this.orders,
    this.error,
    this.currentPage = 1,
  });

  OrdersState copyWith({
    Status? loadOrdersStatus,
    Status? addingOrderToFirestore,
    String? addedOrderIdToFirestore,
    int? pressedAcceptOfOrderIndex,
    PendingOrdersEntity? orders,
    Object? error,
    int? currentPage,
  }) => OrdersState(
    loadOrdersStatus: loadOrdersStatus ?? this.loadOrdersStatus,
    addingOrderToFirestore:
        addingOrderToFirestore ?? this.addingOrderToFirestore,
    addedOrderIdToFirestore:
        addedOrderIdToFirestore ?? this.addedOrderIdToFirestore,
    pressedAcceptOfOrderIndex:
        pressedAcceptOfOrderIndex ?? this.pressedAcceptOfOrderIndex,
    orders: orders ?? this.orders,
    error: error ?? this.error,
    currentPage: currentPage ?? this.currentPage,
  );

  @override
  List<Object?> get props => [
    loadOrdersStatus,
    orders,
    error,
    currentPage,
    addingOrderToFirestore,
    addedOrderIdToFirestore,
  ];
}

sealed class OrdersIntent {}

class LoadOrdersIntent extends OrdersIntent {}

class LoadMoreOrdersIntent extends OrdersIntent {}

class RefreshOrdersIntent extends OrdersIntent {}

class OnAcceptButtonClick extends OrdersIntent {
  String driverId;
  OrderEntityFirestore orderEntity;
  int pendingOrderIndex;

  OnAcceptButtonClick({
    required this.driverId,
    required this.orderEntity,
    required this.pendingOrderIndex,
  });
}

class RejectOrderIntent {
  final String orderId;

  RejectOrderIntent(this.orderId);
}
