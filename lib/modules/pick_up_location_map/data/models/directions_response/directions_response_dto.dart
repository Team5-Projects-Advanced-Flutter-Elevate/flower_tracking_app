import 'package:flower_tracking_app/modules/pick_up_location_map/domain/entities/directions_response/directions_response_entity.dart';

/// type : "FeatureCollection"
/// bbox : [8.681423,49.414599,8.690123,49.420514]
/// features : [{"bbox":[8.681423,49.414599,8.690123,49.420514],"type":"Feature","properties":{"segments":[{"distance":1408.8,"duration":281.9,"steps":[{"distance":1.8,"duration":0.4,"type":11,"instruction":"Head west on Gerhart-Hauptmann-Straße","name":"Gerhart-Hauptmann-Straße","way_points":[0,1]},{"distance":313.8,"duration":75.3,"type":1,"instruction":"Turn right onto Wielandtstraße","name":"Wielandtstraße","way_points":[1,6]},{"distance":500.8,"duration":76.4,"type":1,"instruction":"Turn right onto Mönchhofstraße","name":"Mönchhofstraße","way_points":[6,17]},{"distance":251.9,"duration":60.5,"type":0,"instruction":"Turn left onto Erwin-Rohde-Straße","name":"Erwin-Rohde-Straße","way_points":[17,21]},{"distance":126.8,"duration":30.4,"type":1,"instruction":"Turn right onto Moltkestraße","name":"Moltkestraße","way_points":[21,22]},{"distance":83.0,"duration":7.5,"type":2,"instruction":"Turn sharp left onto Handschuhsheimer Landstraße, B 3","name":"Handschuhsheimer Landstraße, B 3","way_points":[22,24]},{"distance":130.6,"duration":31.3,"type":0,"instruction":"Turn left onto Roonstraße","name":"Roonstraße","way_points":[24,25]},{"distance":0.0,"duration":0.0,"type":10,"instruction":"Arrive at Roonstraße, straight ahead","name":"-","way_points":[25,25]}]}],"way_points":[0,25],"summary":{"distance":1408.8,"duration":281.9}},"geometry":{"coordinates":[[8.681495,49.414599],[8.68147,49.414599],[8.681488,49.41465],[8.681423,49.415746],[8.681656,49.41659],[8.681826,49.417081],[8.681881,49.417392],[8.682461,49.417389],[8.682676,49.417387],[8.682781,49.417386],[8.683023,49.417384],[8.683595,49.417372],[8.68536,49.417365],[8.686407,49.417365],[8.68703,49.41736],[8.687467,49.417351],[8.688212,49.417358],[8.688802,49.417381],[8.68871,49.418194],[8.688647,49.418465],[8.688539,49.418964],[8.688398,49.41963],[8.690123,49.419833],[8.689854,49.420217],[8.689653,49.420514],[8.687871,49.420322]],"type":"LineString"}}]
/// metadata : {"attribution":"openrouteservice.org | OpenStreetMap contributors","service":"routing","timestamp":1748939360143,"query":{"coordinates":[[8.681495,49.41461],[8.687872,49.420318]],"profile":"driving-car","profileName":"driving-car","format":"geojson"},"engine":{"version":"9.2.0","build_date":"2025-05-06T08:31:01Z","graph_date":"2025-06-01T13:27:25Z"}}
class DirectionsResponseDto {
  DirectionsResponseDto({this.type, this.bbox, this.features, this.metadata});

  DirectionsResponseDto.fromJson(dynamic json) {
    type = json['type'];
    bbox = json['bbox'] != null ? json['bbox'].cast<num>() : [];
    if (json['features'] != null) {
      features = [];
      json['features'].forEach((v) {
        features?.add(FeatureDto.fromJson(v));
      });
    }
    metadata =
        json['metadata'] != null
            ? MetadataDto.fromJson(json['metadata'])
            : null;
  }

  String? type;
  List<num>? bbox;
  List<FeatureDto>? features;
  MetadataDto? metadata;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['bbox'] = bbox;
    if (features != null) {
      map['features'] = features?.map((v) => v.toJson()).toList();
    }
    if (metadata != null) {
      map['metadata'] = metadata?.toJson();
    }
    return map;
  }

  DirectionsResponseEntity convertIntoEntity() {
    return DirectionsResponseEntity(
      type: type,
      bbox: bbox,
      features: features?.map((e) => e.convertIntoEntity()).toList(),
      metadata: metadata?.convertIntoEntity(),
    );
  }
}

/// attribution : "openrouteservice.org | OpenStreetMap contributors"
/// service : "routing"
/// timestamp : 1748939360143
/// query : {"coordinates":[[8.681495,49.41461],[8.687872,49.420318]],"profile":"driving-car","profileName":"driving-car","format":"geojson"}
/// engine : {"version":"9.2.0","build_date":"2025-05-06T08:31:01Z","graph_date":"2025-06-01T13:27:25Z"}

class MetadataDto {
  MetadataDto({
    this.attribution,
    this.service,
    this.timestamp,
    this.query,
    this.engine,
  });

  MetadataDto.fromJson(dynamic json) {
    attribution = json['attribution'];
    service = json['service'];
    timestamp = json['timestamp'];
    query = json['query'] != null ? QueryDto.fromJson(json['query']) : null;
    engine = json['engine'] != null ? EngineDto.fromJson(json['engine']) : null;
  }

  String? attribution;
  String? service;
  num? timestamp;
  QueryDto? query;
  EngineDto? engine;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['attribution'] = attribution;
    map['service'] = service;
    map['timestamp'] = timestamp;
    if (query != null) {
      map['query'] = query?.toJson();
    }
    if (engine != null) {
      map['engine'] = engine?.toJson();
    }
    return map;
  }

  MetadataEntity convertIntoEntity() {
    return MetadataEntity(
      attribution: attribution,
      service: service,
      timestamp: timestamp,
      query: query?.convertIntoEntity(),
      engine: engine?.convertIntoEntity(),
    );
  }
}

/// version : "9.2.0"
/// build_date : "2025-05-06T08:31:01Z"
/// graph_date : "2025-06-01T13:27:25Z"

class EngineDto {
  EngineDto({this.version, this.buildDate, this.graphDate});

  EngineDto.fromJson(dynamic json) {
    version = json['version'];
    buildDate = json['build_date'];
    graphDate = json['graph_date'];
  }

  String? version;
  String? buildDate;
  String? graphDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['build_date'] = buildDate;
    map['graph_date'] = graphDate;
    return map;
  }

  EngineEntity convertIntoEntity() {
    return EngineEntity(
      version: version,
      buildDate: buildDate,
      graphDate: graphDate,
    );
  }
}

/// coordinates : [[8.681495,49.41461],[8.687872,49.420318]]
/// profile : "driving-car"
/// profileName : "driving-car"
/// format : "geojson"

class QueryDto {
  QueryDto({this.coordinates, this.profile, this.profileName, this.format});

  QueryDto.fromJson(dynamic json) {
    coordinates =
        json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
    profile = json['profile'];
    profileName = json['profileName'];
    format = json['format'];
  }

  List<List<num>>? coordinates;
  String? profile;
  String? profileName;
  String? format;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['profile'] = profile;
    map['profileName'] = profileName;
    map['format'] = format;
    return map;
  }

  QueryEntity convertIntoEntity() {
    return QueryEntity(
      coordinates: coordinates,
      profile: profile,
      profileName: profileName,
      format: format,
    );
  }
}

/// bbox : [8.681423,49.414599,8.690123,49.420514]
/// type : "Feature"
/// properties : {"segments":[{"distance":1408.8,"duration":281.9,"steps":[{"distance":1.8,"duration":0.4,"type":11,"instruction":"Head west on Gerhart-Hauptmann-Straße","name":"Gerhart-Hauptmann-Straße","way_points":[0,1]},{"distance":313.8,"duration":75.3,"type":1,"instruction":"Turn right onto Wielandtstraße","name":"Wielandtstraße","way_points":[1,6]},{"distance":500.8,"duration":76.4,"type":1,"instruction":"Turn right onto Mönchhofstraße","name":"Mönchhofstraße","way_points":[6,17]},{"distance":251.9,"duration":60.5,"type":0,"instruction":"Turn left onto Erwin-Rohde-Straße","name":"Erwin-Rohde-Straße","way_points":[17,21]},{"distance":126.8,"duration":30.4,"type":1,"instruction":"Turn right onto Moltkestraße","name":"Moltkestraße","way_points":[21,22]},{"distance":83.0,"duration":7.5,"type":2,"instruction":"Turn sharp left onto Handschuhsheimer Landstraße, B 3","name":"Handschuhsheimer Landstraße, B 3","way_points":[22,24]},{"distance":130.6,"duration":31.3,"type":0,"instruction":"Turn left onto Roonstraße","name":"Roonstraße","way_points":[24,25]},{"distance":0.0,"duration":0.0,"type":10,"instruction":"Arrive at Roonstraße, straight ahead","name":"-","way_points":[25,25]}]}],"way_points":[0,25],"summary":{"distance":1408.8,"duration":281.9}}
/// geometry : {"coordinates":[[8.681495,49.414599],[8.68147,49.414599],[8.681488,49.41465],[8.681423,49.415746],[8.681656,49.41659],[8.681826,49.417081],[8.681881,49.417392],[8.682461,49.417389],[8.682676,49.417387],[8.682781,49.417386],[8.683023,49.417384],[8.683595,49.417372],[8.68536,49.417365],[8.686407,49.417365],[8.68703,49.41736],[8.687467,49.417351],[8.688212,49.417358],[8.688802,49.417381],[8.68871,49.418194],[8.688647,49.418465],[8.688539,49.418964],[8.688398,49.41963],[8.690123,49.419833],[8.689854,49.420217],[8.689653,49.420514],[8.687871,49.420322]],"type":"LineString"}

class FeatureDto {
  FeatureDto({this.bbox, this.type, this.properties, this.geometry});

  FeatureDto.fromJson(dynamic json) {
    bbox = json['bbox'] != null ? json['bbox'].cast<num>() : [];
    type = json['type'];
    properties =
        json['properties'] != null
            ? PropertiesDto.fromJson(json['properties'])
            : null;
    geometry =
        json['geometry'] != null
            ? GeometryDto.fromJson(json['geometry'])
            : null;
  }

  List<num>? bbox;
  String? type;
  PropertiesDto? properties;
  GeometryDto? geometry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bbox'] = bbox;
    map['type'] = type;
    if (properties != null) {
      map['properties'] = properties?.toJson();
    }
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    return map;
  }

  FeatureEntity convertIntoEntity() {
    return FeatureEntity(
      bbox: bbox,
      type: type,
      properties: properties?.convertIntoEntity(),
      geometry: geometry?.convertIntoEntity(),
    );
  }
}

/// coordinates : [[8.681495,49.414599],[8.68147,49.414599],[8.681488,49.41465],[8.681423,49.415746],[8.681656,49.41659],[8.681826,49.417081],[8.681881,49.417392],[8.682461,49.417389],[8.682676,49.417387],[8.682781,49.417386],[8.683023,49.417384],[8.683595,49.417372],[8.68536,49.417365],[8.686407,49.417365],[8.68703,49.41736],[8.687467,49.417351],[8.688212,49.417358],[8.688802,49.417381],[8.68871,49.418194],[8.688647,49.418465],[8.688539,49.418964],[8.688398,49.41963],[8.690123,49.419833],[8.689854,49.420217],[8.689653,49.420514],[8.687871,49.420322]]
/// type : "LineString"

class GeometryDto {
  GeometryDto({this.coordinates, this.type});

  GeometryDto.fromJson(dynamic json) {
    coordinates =
        json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
    type = json['type'];
  }

  List<List<num>>? coordinates;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['type'] = type;
    return map;
  }

  GeometryEntity convertIntoEntity() {
    return GeometryEntity(coordinates: coordinates, type: type);
  }
}

/// segments : [{"distance":1408.8,"duration":281.9,"steps":[{"distance":1.8,"duration":0.4,"type":11,"instruction":"Head west on Gerhart-Hauptmann-Straße","name":"Gerhart-Hauptmann-Straße","way_points":[0,1]},{"distance":313.8,"duration":75.3,"type":1,"instruction":"Turn right onto Wielandtstraße","name":"Wielandtstraße","way_points":[1,6]},{"distance":500.8,"duration":76.4,"type":1,"instruction":"Turn right onto Mönchhofstraße","name":"Mönchhofstraße","way_points":[6,17]},{"distance":251.9,"duration":60.5,"type":0,"instruction":"Turn left onto Erwin-Rohde-Straße","name":"Erwin-Rohde-Straße","way_points":[17,21]},{"distance":126.8,"duration":30.4,"type":1,"instruction":"Turn right onto Moltkestraße","name":"Moltkestraße","way_points":[21,22]},{"distance":83.0,"duration":7.5,"type":2,"instruction":"Turn sharp left onto Handschuhsheimer Landstraße, B 3","name":"Handschuhsheimer Landstraße, B 3","way_points":[22,24]},{"distance":130.6,"duration":31.3,"type":0,"instruction":"Turn left onto Roonstraße","name":"Roonstraße","way_points":[24,25]},{"distance":0.0,"duration":0.0,"type":10,"instruction":"Arrive at Roonstraße, straight ahead","name":"-","way_points":[25,25]}]}]
/// way_points : [0,25]
/// summary : {"distance":1408.8,"duration":281.9}

class PropertiesDto {
  PropertiesDto({this.segments, this.wayPoints, this.summary});

  PropertiesDto.fromJson(dynamic json) {
    if (json['segments'] != null) {
      segments = [];
      json['segments'].forEach((v) {
        segments?.add(SegmentDto.fromJson(v));
      });
    }
    wayPoints =
        json['way_points'] != null ? json['way_points'].cast<num>() : [];
    summary =
        json['summary'] != null ? SummaryDto.fromJson(json['summary']) : null;
  }

  List<SegmentDto>? segments;
  List<num>? wayPoints;
  SummaryDto? summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (segments != null) {
      map['segments'] = segments?.map((v) => v.toJson()).toList();
    }
    map['way_points'] = wayPoints;
    if (summary != null) {
      map['summary'] = summary?.toJson();
    }
    return map;
  }

  PropertiesEntity convertIntoEntity() {
    return PropertiesEntity(
      segments: segments?.map((e) => e.convertIntoEntity()).toList(),
      wayPoints: wayPoints,
      summary: summary?.convertIntoEntity(),
    );
  }
}

/// distance : 1408.8
/// duration : 281.9

class SummaryDto {
  SummaryDto({this.distance, this.duration});

  SummaryDto.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
  }

  num? distance;
  num? duration;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    return map;
  }

  SummaryEntity convertIntoEntity() {
    return SummaryEntity(distance: distance, duration: duration);
  }
}

/// distance : 1408.8
/// duration : 281.9
/// steps : [{"distance":1.8,"duration":0.4,"type":11,"instruction":"Head west on Gerhart-Hauptmann-Straße","name":"Gerhart-Hauptmann-Straße","way_points":[0,1]},{"distance":313.8,"duration":75.3,"type":1,"instruction":"Turn right onto Wielandtstraße","name":"Wielandtstraße","way_points":[1,6]},{"distance":500.8,"duration":76.4,"type":1,"instruction":"Turn right onto Mönchhofstraße","name":"Mönchhofstraße","way_points":[6,17]},{"distance":251.9,"duration":60.5,"type":0,"instruction":"Turn left onto Erwin-Rohde-Straße","name":"Erwin-Rohde-Straße","way_points":[17,21]},{"distance":126.8,"duration":30.4,"type":1,"instruction":"Turn right onto Moltkestraße","name":"Moltkestraße","way_points":[21,22]},{"distance":83.0,"duration":7.5,"type":2,"instruction":"Turn sharp left onto Handschuhsheimer Landstraße, B 3","name":"Handschuhsheimer Landstraße, B 3","way_points":[22,24]},{"distance":130.6,"duration":31.3,"type":0,"instruction":"Turn left onto Roonstraße","name":"Roonstraße","way_points":[24,25]},{"distance":0.0,"duration":0.0,"type":10,"instruction":"Arrive at Roonstraße, straight ahead","name":"-","way_points":[25,25]}]

class SegmentDto {
  SegmentDto({this.distance, this.duration, this.steps});

  SegmentDto.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
    if (json['steps'] != null) {
      steps = [];
      json['steps'].forEach((v) {
        steps?.add(StepDto.fromJson(v));
      });
    }
  }

  num? distance;
  num? duration;
  List<StepDto>? steps;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    if (steps != null) {
      map['steps'] = steps?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  SegmentEntity convertIntoEntity() {
    return SegmentEntity(
      distance: distance,
      duration: duration,
      steps: steps?.map((e) => e.convertIntoEntity()).toList(),
    );
  }
}

/// distance : 1.8
/// duration : 0.4
/// type : 11
/// instruction : "Head west on Gerhart-Hauptmann-Straße"
/// name : "Gerhart-Hauptmann-Straße"
/// way_points : [0,1]

class StepDto {
  StepDto({
    this.distance,
    this.duration,
    this.type,
    this.instruction,
    this.name,
    this.wayPoints,
  });

  StepDto.fromJson(dynamic json) {
    distance = json['distance'];
    duration = json['duration'];
    type = json['type'];
    instruction = json['instruction'];
    name = json['name'];
    wayPoints =
        json['way_points'] != null ? json['way_points'].cast<num>() : [];
  }

  num? distance;
  num? duration;
  num? type;
  String? instruction;
  String? name;
  List<num>? wayPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['duration'] = duration;
    map['type'] = type;
    map['instruction'] = instruction;
    map['name'] = name;
    map['way_points'] = wayPoints;
    return map;
  }

  StepEntity convertIntoEntity() {
    return StepEntity(
      distance: distance,
      duration: duration,
      type: type,
      instruction: instruction,
      name: name,
      wayPoints: wayPoints,
    );
  }
}
