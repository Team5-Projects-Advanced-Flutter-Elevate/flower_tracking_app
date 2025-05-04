
class CountryModel {
  CountryModel({
      this.isoCode,
      this.name,
      this.phoneCode,
      this.flag,
      this.currency,
      this.latitude,
      this.longitude,
      this.timezones,});

  CountryModel.fromJson(dynamic json) {
    isoCode = json['isoCode'];
    name = json['name'];
    phoneCode = json['phoneCode'];
    flag = json['flag'];
    currency = json['currency'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['timezones'] != null) {
      timezones = [];
      json['timezones'].forEach((v) {
        timezones?.add(Timezones.fromJson(v));
      });
    }
  }
  String? isoCode;
  String? name;
  String? phoneCode;
  String? flag;
  String? currency;
  String? latitude;
  String? longitude;
  List<Timezones>? timezones;

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

}

class Timezones {
  Timezones({
    this.zoneName,
    this.gmtOffset,
    this.gmtOffsetName,
    this.abbreviation,
    this.tzName,});

  Timezones.fromJson(dynamic json) {
    zoneName = json['zoneName'];
    gmtOffset = json['gmtOffset'];
    gmtOffsetName = json['gmtOffsetName'];
    abbreviation = json['abbreviation'];
    tzName = json['tzName'];
  }
  String? zoneName;
  num? gmtOffset;
  String? gmtOffsetName;
  String? abbreviation;
  String? tzName;

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