import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  const CountryModel({
    this.isoCode,
    this.name,
    this.phoneCode,
    this.flag,
    this.currency,
    this.latitude,
    this.longitude,
    this.timezones,
  });

  CountryModel.fromJson(dynamic json)
    : isoCode = json['isoCode'],
      name = json['name'],
      phoneCode = json['phoneCode'],
      flag = json['flag'],
      currency = json['currency'],
      latitude = json['latitude'],
      longitude = json['longitude'],
      timezones =
          json['timezones'] != null
              ? (json['timezones'] as List)
                  .map((v) => Timezones.fromJson(v))
                  .toList()
              : null;

  final String? isoCode;
  final String? name;
  final String? phoneCode;
  final String? flag;
  final String? currency;
  final String? latitude;
  final String? longitude;
  final List<Timezones>? timezones;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isoCode'] = isoCode;
    map['name'] = name;
    map['phoneCode'] = phoneCode;
    map['flag'] = flag;
    map['currency'] = currency;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    if (timezones != null) {
      map['timezones'] = timezones?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    isoCode,
    name,
    phoneCode,
    flag,
    currency,
    latitude,
    longitude,
    timezones,
  ];
}

class Timezones {
  const Timezones({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,
  });

  factory Timezones.fromJson(Map<String, dynamic> json) {
    return Timezones(
      zoneName: json['zoneName'],
      gmtOffset: json['gmtOffset'],
      gmtOffsetName: json['gmtOffsetName'],
      abbreviation: json['abbreviation'],
      tzName: json['tzName'],
    );
  }

  final String? zoneName;
  final num? gmtOffset;
  final String? gmtOffsetName;
  final String? abbreviation;
  final String? tzName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['zoneName'] = zoneName;
    map['gmtOffset'] = gmtOffset;
    map['gmtOffsetName'] = gmtOffsetName;
    map['abbreviation'] = abbreviation;
    map['tzName'] = tzName;
    return map;
  }
}
