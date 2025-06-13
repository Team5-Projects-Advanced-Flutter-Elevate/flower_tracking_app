import 'package:equatable/equatable.dart';

class VehicleResponseEntity extends Equatable {
  final String? message;
  final List<VehicleEntity>? vehicles;
  final VehicleEntity? vehicle;

  const VehicleResponseEntity({this.message, this.vehicles, this.vehicle});

  @override
  // TODO: implement props
  List<Object?> get props => [message, vehicles, vehicle];
}

class VehicleEntity extends Equatable {
  final String? id;
  final String? type;
  final String? image;

  const VehicleEntity({this.id, this.type, this.image});

  @override
  // TODO: implement props
  List<Object?> get props => [id, type, image];
}
