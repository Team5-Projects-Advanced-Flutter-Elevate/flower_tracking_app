import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/modules/home/data/models/orders_client_model.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';

class PendingOrdersEntity extends Equatable {
  final String? message;
  final Metadata? metadata;
  final List<OrderEntityFirestore>? orders;

  const PendingOrdersEntity({this.message, this.metadata, this.orders});

  PendingOrdersEntity copyWith({
    String? message,
    Metadata? metadata,
    List<OrderEntityFirestore>? orders,
  }) {
    return PendingOrdersEntity(
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [message, metadata, orders];
}
