import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/modules/home/data/models/orders_client_model.dart';

class PendingOrdersEntity extends Equatable {
  final String message;
  final Metadata? metadata;
  final List<OrderEntity> orders;

  const PendingOrdersEntity({
    required this.message,
    this.metadata,
    required this.orders,
  });

  factory PendingOrdersEntity.fromResponse(PendingOrdersResponse response) {
    return PendingOrdersEntity(
      message: response.message,
      metadata: response.metadata,
      orders: response.orders?.map((order) => OrderEntity.fromModel(order)).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [message, metadata, orders];
}

class OrderEntity extends Equatable {
  final String id;
  final User user;
  final List<OrderItem> orderItems;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String createdAt;
  final String updatedAt;
  final String orderNumber;
  final Store store;
  final ShippingAddress? shippingAddress;

  const OrderEntity({
    required this.id,
    required this.user,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.store,
    this.shippingAddress,
  });

  factory OrderEntity.fromModel(Order order) {
    return OrderEntity(
      id: order.id ?? '',
      user: order.user ?? User(id: '', firstName: 'Unknown', lastName: '', email: '', gender: '', phone: '', photo: ''),
      orderItems: order.orderItems ?? [],
      totalPrice: order.totalPrice ?? 0.0,
      paymentType: order.paymentType ?? '',
      isPaid: order.isPaid ?? false,
      isDelivered: order.isDelivered ?? false,
      state: order.state ?? '',
      createdAt: order.createdAt ?? '',
      updatedAt: order.updatedAt ?? '',
      orderNumber: order.orderNumber ?? '',
      store: order.store ?? Store(name: 'Unknown', image: '', address: '', phoneNumber: '', latLong: ''),
      shippingAddress: order.shippingAddress,
    );
  }

  @override
  List<Object?> get props => [
        id,
        user,
        orderItems,
        totalPrice,
        paymentType,
        isPaid,
        isDelivered,
        state,
        createdAt,
        updatedAt,
        orderNumber,
        store,
        shippingAddress,
      ];
}