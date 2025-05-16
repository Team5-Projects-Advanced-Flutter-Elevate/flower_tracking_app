import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/modules/home/data/models/orders_client_model.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/domain/entities/order/order_entity_firestore.dart';

class PendingOrdersEntity extends Equatable {
  final String? message;
  final Metadata? metadata;
  final List<OrderEntityFirestore>? orders;

  const PendingOrdersEntity({
     this.message,
     this.metadata,
     this.orders,
  });

  @override
  List<Object?> get props => [message, metadata, orders];
}
