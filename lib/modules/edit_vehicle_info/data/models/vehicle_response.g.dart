// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleResponse _$VehicleResponseFromJson(Map<String, dynamic> json) =>
    VehicleResponse(
      message: json['message'] as String?,
      metadata:
          json['metadata'] == null
              ? null
              : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      vehicles:
          (json['vehicles'] as List<dynamic>?)
              ?.map((e) => Vehicle.fromJson(e as Map<String, dynamic>))
              .toList(),
      vehicle:
          json['vehicle'] == null
              ? null
              : Vehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VehicleResponseToJson(VehicleResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'metadata': instance.metadata,
      'vehicles': instance.vehicles,
      'vehicle': instance.vehicle,
    };

Metadata _$MetadataFromJson(Map<String, dynamic> json) => Metadata(
  currentPage: (json['currentPage'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  totalItems: (json['totalItems'] as num?)?.toInt(),
);

Map<String, dynamic> _$MetadataToJson(Metadata instance) => <String, dynamic>{
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'limit': instance.limit,
  'totalItems': instance.totalItems,
};

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
  id: json['_id'] as String?,
  type: json['type'] as String?,
  image: json['image'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  v: (json['__v'] as num?)?.toInt(),
);

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
  '_id': instance.id,
  'type': instance.type,
  'image': instance.image,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  '__v': instance.v,
};
