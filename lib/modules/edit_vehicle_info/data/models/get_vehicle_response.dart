import 'package:flower_tracking_app/modules/apply/domain/entities/vehicle_response_entity.dart';

class GetVehicleResponse {
  String? message;
  Vehicle? vehicle;

  GetVehicleResponse({this.message, this.vehicle});

  GetVehicleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    vehicle =
        json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
  }

  VehicleEntity toEntity() => VehicleEntity(
    id: vehicle?.sId,
    type: vehicle?.type,
    image: vehicle?.image,
  );
}

class Vehicle {
  String? sId;
  String? type;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Vehicle({
    this.sId,
    this.type,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    type = json['type'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Vehicle toEntity() => Vehicle(sId: sId, type: type, image: image);
}
