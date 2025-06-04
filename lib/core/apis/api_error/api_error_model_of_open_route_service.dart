/// error : {"code":2004,"message":"Request parameters exceed the server configuration limits. The approximated route distance must not be greater than 6000000.0 meters."}
/// info : {"engine":{"build_date":"2025-05-06T08:31:01Z","graph_version":"1","graph_date":"2025-06-01T13:27:25Z","version":"9.2.0"},"timestamp":1749044168320}
class ApiErrorModelOfOpenRouteService {
  ApiErrorModelOfOpenRouteService({
      this.error, 
      this.info,});

  ApiErrorModelOfOpenRouteService.fromJson(dynamic json) {
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    info = json['info'] != null ? Info.fromJson(json['info']) : null;
  }
  Error? error;
  Info? info;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (error != null) {
      map['error'] = error?.toJson();
    }
    if (info != null) {
      map['info'] = info?.toJson();
    }
    return map;
  }

}

/// engine : {"build_date":"2025-05-06T08:31:01Z","graph_version":"1","graph_date":"2025-06-01T13:27:25Z","version":"9.2.0"}
/// timestamp : 1749044168320

class Info {
  Info({
      this.engine, 
      this.timestamp,});

  Info.fromJson(dynamic json) {
    engine = json['engine'] != null ? Engine.fromJson(json['engine']) : null;
    timestamp = json['timestamp'];
  }
  Engine? engine;
  num? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (engine != null) {
      map['engine'] = engine?.toJson();
    }
    map['timestamp'] = timestamp;
    return map;
  }

}

/// build_date : "2025-05-06T08:31:01Z"
/// graph_version : "1"
/// graph_date : "2025-06-01T13:27:25Z"
/// version : "9.2.0"

class Engine {
  Engine({
      this.buildDate, 
      this.graphVersion, 
      this.graphDate, 
      this.version,});

  Engine.fromJson(dynamic json) {
    buildDate = json['build_date'];
    graphVersion = json['graph_version'];
    graphDate = json['graph_date'];
    version = json['version'];
  }
  String? buildDate;
  String? graphVersion;
  String? graphDate;
  String? version;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['build_date'] = buildDate;
    map['graph_version'] = graphVersion;
    map['graph_date'] = graphDate;
    map['version'] = version;
    return map;
  }

}

/// code : 2004
/// message : "Request parameters exceed the server configuration limits. The approximated route distance must not be greater than 6000000.0 meters."

class Error {
  Error({
      this.code, 
      this.message,});

  Error.fromJson(dynamic json) {
    code = json['code'];
    message = json['message'];
  }
  num? code;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    return map;
  }

}