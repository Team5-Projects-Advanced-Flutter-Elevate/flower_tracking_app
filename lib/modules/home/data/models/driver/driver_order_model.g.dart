// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DriverOrderModel _$DriverOrderModelFromJson(Map<String, dynamic> json) =>
    DriverOrderModel(
      id: json['_id'] as String,
      driver: json['driver'] as String,
      order: OrderModel.fromJson(json['order'] as Map<String, dynamic>),
      store: StoreModel.fromJson(json['store'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$DriverOrderModelToJson(DriverOrderModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'driver': instance.driver,
      'order': instance.order,
      'store': instance.store,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
