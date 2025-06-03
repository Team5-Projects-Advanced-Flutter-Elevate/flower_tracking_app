/// coordinates : [[8.681495,49.41461],[8.687872,49.420318]]
class DirectionsRequestDto {
  DirectionsRequestDto({this.coordinates});

  List<List<num>>? coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    return map;
  }
}
