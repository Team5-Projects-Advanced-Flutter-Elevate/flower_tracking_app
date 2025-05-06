class VehicleResponseEntity {
  final String? message;
  final List<VehicleEntity>? vehicles;

  VehicleResponseEntity({this.message, this.vehicles});
}

class VehicleEntity {
  final String? id;
  final String? type;
  final String? image;

  VehicleEntity({this.id, this.type, this.image});
}
