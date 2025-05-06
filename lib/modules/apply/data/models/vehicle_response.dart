import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/vehicle_response_entity.dart';

part 'vehicle_response.g.dart';

@JsonSerializable()
class VehicleResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final Metadata? metadata;
  @JsonKey(name: "vehicles")
  final List<Vehicle>? vehicles;

  VehicleResponse({this.message, this.metadata, this.vehicles});

  factory VehicleResponse.fromJson(Map<String, dynamic> json) {
    return _$VehicleResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehicleResponseToJson(this);
  }

  VehicleResponseEntity toEntity() => VehicleResponseEntity(
    message: message,
    vehicles: vehicles?.map((vehicle) => vehicle.toEntity()).toList(),
  );
}

@JsonSerializable()
class Metadata {
  @JsonKey(name: "currentPage")
  final int? currentPage;
  @JsonKey(name: "totalPages")
  final int? totalPages;
  @JsonKey(name: "limit")
  final int? limit;
  @JsonKey(name: "totalItems")
  final int? totalItems;

  Metadata({this.currentPage, this.totalPages, this.limit, this.totalItems});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetadataToJson(this);
  }
}

@JsonSerializable()
class Vehicle {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "image")
  final String? image;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;

  Vehicle({
    this.id,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return _$VehicleFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VehicleToJson(this);
  }

  VehicleEntity toEntity() => VehicleEntity(id: id, type: type, image: image);
}
