import 'package:equatable/equatable.dart';

class VehicleResponseEntity extends Equatable {
  final String? message;
  final List<VehicleEntity>? vehicles;

  const VehicleResponseEntity({this.message, this.vehicles});

  @override
  // TODO: implement props
  List<Object?> get props => [
    message,
    vehicles,
  ];
}

class VehicleEntity extends Equatable {
  final String? id;
  final String? type;
  final String? image;

  const VehicleEntity({this.id, this.type, this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    type,
    image
  ];
}
