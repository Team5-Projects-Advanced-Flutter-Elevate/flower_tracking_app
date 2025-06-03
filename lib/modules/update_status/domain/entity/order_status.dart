class OrderStatusUpdateEntity {
  final String? message;
  final OrdersEntity? orders;

  OrderStatusUpdateEntity({
    required this.message,
    required this.orders,
  });
}

class OrdersEntity {
  final String? id;
  final String? user;
  final List<OrderItemEntity> orderItems;
  final num? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderNumber;
  final num? v;

  OrdersEntity({
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
    required this.v,
  });
}

class OrderItemEntity {
  final String? product;
  final num? price;
  final num? quantity;
  final String? id;

  OrderItemEntity({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });
}
