class GetVehicleResponse {
  String? message;
  Vehicle? vehicle;

  GetVehicleResponse({this.message, this.vehicle});

  GetVehicleResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    vehicle =
        json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
  }

  GetVehicleResponse toEntity() =>
      GetVehicleResponse(message: message, vehicle: vehicle?.toEntity());
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
