import 'package:flower_tracking_app/modules/home/data/models/driver/product_model.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  final ProductModel? product;
  final double price;
  final int quantity;
  @JsonKey(name: '_id')
  final String id;

  OrderItemModel({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);

  OrderItem toEntity() => OrderItem(
    product: product?.toEntity(),
    price: price,
    quantity: quantity,
    id: id,
  );
}
