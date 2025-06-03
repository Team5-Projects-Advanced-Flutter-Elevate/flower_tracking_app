import '../../domain/entity/order_status.dart';

class OrderStatusUpdate {
  OrderStatusUpdate({required this.message, required this.orders});

  final String? message;
  final Orders? orders;

  factory OrderStatusUpdate.fromJson(Map<String, dynamic> json) {
    return OrderStatusUpdate(
      message: json["message"],
      orders: json["orders"] == null ? null : Orders.fromJson(json["orders"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "orders": orders?.toJson(),
  };
}

class Orders {
  Orders({
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

  final String? id;
  final String? user;
  final List<OrderItem> orderItems;
  final num? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderNumber;
  final num? v;

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json["_id"],
      user: json["user"],
      orderItems:
          json["orderItems"] == null
              ? []
              : List<OrderItem>.from(
                json["orderItems"]!.map((x) => OrderItem.fromJson(x)),
              ),
      totalPrice: json["totalPrice"],
      paymentType: json["paymentType"],
      isPaid: json["isPaid"],
      isDelivered: json["isDelivered"],
      state: json["state"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      orderNumber: json["orderNumber"],
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "orderItems": orderItems.map((x) => x?.toJson()).toList(),
    "totalPrice": totalPrice,
    "paymentType": paymentType,
    "isPaid": isPaid,
    "isDelivered": isDelivered,
    "state": state,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "orderNumber": orderNumber,
    "__v": v,
  };
}

class OrderItem {
  OrderItem({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  final String? product;
  final num? price;
  final num? quantity;
  final String? id;

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      product: json["product"],
      price: json["price"],
      quantity: json["quantity"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "product": product,
    "price": price,
    "quantity": quantity,
    "_id": id,
  };








}
extension OrderStatusUpdateMapper on OrderStatusUpdate {
  OrderStatusUpdateEntity toEntity() {
    return OrderStatusUpdateEntity(
      message: message,
      orders: orders?.toEntity(),
    );
  }
}

extension OrdersMapper on Orders {
  OrdersEntity toEntity() {
    return OrdersEntity(
      id: id,
      user: user,
      orderItems: orderItems.map((item) => item.toEntity()).toList(),
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
      v: v,
    );
  }
}

extension OrderItemMapper on OrderItem {
  OrderItemEntity toEntity() {
    return OrderItemEntity(
      product: product,
      price: price,
      quantity: quantity,
      id: id,
    );
  }
}
