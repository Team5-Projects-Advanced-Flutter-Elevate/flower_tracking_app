class DirectionsResponseEntity {
  DirectionsResponseEntity({
    this.type,
    this.bbox,
    this.features,
    this.metadata,
  });

  String? type;
  List<num>? bbox;
  List<FeatureEntity>? features;
  MetadataEntity? metadata;
}

class MetadataEntity {
  MetadataEntity({
    this.attribution,
    this.service,
    this.timestamp,
    this.query,
    this.engine,
  });

  String? attribution;
  String? service;
  num? timestamp;
  QueryEntity? query;
  EngineEntity? engine;
}

class EngineEntity {
  EngineEntity({this.version, this.buildDate, this.graphDate});

  String? version;
  String? buildDate;
  String? graphDate;
}

class QueryEntity {
  QueryEntity({this.coordinates, this.profile, this.profileName, this.format});

  List<List<num>>? coordinates;
  String? profile;
  String? profileName;
  String? format;
}

class FeatureEntity {
  FeatureEntity({this.bbox, this.type, this.properties, this.geometry});

  List<num>? bbox;
  String? type;
  PropertiesEntity? properties;
  GeometryEntity? geometry;
}

class GeometryEntity {
  GeometryEntity({this.coordinates, this.type});

  List<List<num>>? coordinates;
  String? type;
}

class PropertiesEntity {
  PropertiesEntity({this.segments, this.wayPoints, this.summary});

  List<SegmentEntity>? segments;
  List<num>? wayPoints;
  SummaryEntity? summary;
}

class SummaryEntity {
  SummaryEntity({this.distance, this.duration});

  num? distance;
  num? duration;
}

class SegmentEntity {
  SegmentEntity({this.distance, this.duration, this.steps});

  num? distance;
  num? duration;
  List<StepEntity>? steps;
}

class StepEntity {
  StepEntity({
    this.distance,
    this.duration,
    this.type,
    this.instruction,
    this.name,
    this.wayPoints,
  });

  num? distance;
  num? duration;
  num? type;
  String? instruction;
  String? name;
  List<num>? wayPoints;
}
