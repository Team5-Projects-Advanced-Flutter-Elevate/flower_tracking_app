import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_request/directions_request_entity.dart';

/// coordinates : [[8.681495,49.41461],[8.687872,49.420318]]
class DirectionsRequestDto {
  DirectionsRequestDto({this.coordinates});

  List<List<num>>? coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    return map;
  }

  static DirectionsRequestDto convertIntoDto(
    DirectionsRequestEntity directionEntity,
  ) {
    return DirectionsRequestDto(coordinates: directionEntity.coordinates);
  }
}
