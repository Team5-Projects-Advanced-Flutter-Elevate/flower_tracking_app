import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'store_model.g.dart';

@JsonSerializable()
class StoreModel {
  final String name;
  final String image;
  final String address;
  final String phoneNumber;
  final String latLong;

  StoreModel({
    required this.name,
    required this.image,
    required this.address,
    required this.phoneNumber,
    required this.latLong,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);

  Store toEntity() => Store(
    name: name,
    image: image,
    address: address,
    phoneNumber: phoneNumber,
    latLong: latLong,
  );
}
