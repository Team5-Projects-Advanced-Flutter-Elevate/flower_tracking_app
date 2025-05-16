import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';

enum Status { idle, loading, success, error }

class OrderDetailsState extends Equatable {
  final Status orderStatus;
  final Status updateOrderStateStatus;
  final OrderEntityFirestore? orderEntityFirestore;
  final Object? error;

  const OrderDetailsState({
    this.orderStatus = Status.idle,
    this.updateOrderStateStatus = Status.idle,
    this.orderEntityFirestore,
    this.error,
  });

  @override
  List<Object?> get props => [orderStatus, orderEntityFirestore, error,updateOrderStateStatus];

  OrderDetailsState copyWith({
    Status? orderStatus,
    Status? updateOrderStateStatus,
    OrderEntityFirestore? orderEntityFirestore,
    Object? error,
  }) {
    return OrderDetailsState(
      orderStatus: orderStatus ?? this.orderStatus,
      updateOrderStateStatus:
          updateOrderStateStatus ?? this.updateOrderStateStatus,
      orderEntityFirestore: orderEntityFirestore ?? this.orderEntityFirestore,
      error: error ?? this.error,
    );
  }
}
