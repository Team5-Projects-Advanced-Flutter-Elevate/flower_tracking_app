import 'package:flower_tracking_app/modules/home/data/models/driver/order_model.dart';
import 'package:flower_tracking_app/modules/home/data/models/driver/store_model.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'driver_order_model.g.dart';

@JsonSerializable()
class DriverOrderModel {
  @JsonKey(name: '_id')
  final String id;
  final String driver;
  final OrderModel order;
  final StoreModel store;
  final String createdAt;
  final String updatedAt;

  DriverOrderModel({
    required this.id,
    required this.driver,
    required this.order,
    required this.store,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverOrderModel.fromJson(Map<String, dynamic> json) =>
      _$DriverOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$DriverOrderModelToJson(this);

  OrderEntity toEntity() => OrderEntity(
    // Explicitly returns OrderEntity
    id: order.id,
    user: order.user.toEntity(),
    orderItems: order.orderItems.map((item) => item.toEntity()).toList(),
    totalPrice: order.totalPrice,
    paymentType: order.paymentType,
    isPaid: order.isPaid,
    isDelivered: order.isDelivered,
    state: order.state,
    createdAt: order.createdAt,
    updatedAt: order.updatedAt,
    orderNumber: order.orderNumber,
    store: store.toEntity(),
  );
}
