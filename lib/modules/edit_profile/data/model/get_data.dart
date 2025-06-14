import '../../domain/entity/get_data.dart';

class GetData {
  GetData({required this.message, required this.driver});

  final String? message;
  final Driver? driver;

  factory GetData.fromJson(Map<String, dynamic> json) {
    return GetData(
      message: json["message"],
      driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "driver": driver?.toJson(),
  };

  // Convert model to entity
  GetDataEntity toEntity() =>
      GetDataEntity(message: message, driver: driver?.toEntity());

  // Convert entity to model
  factory GetData.fromEntity(GetDataEntity entity) => GetData(
    message: entity.message,
    driver: entity.driver != null ? Driver.fromEntity(entity.driver!) : null,
  );
}

class Driver {
  Driver({
    required this.role,
    required this.id,
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.createdAt,
  });

  final String? role;
  final String? id;
  final String? country;
  final String? firstName;
  final String? lastName;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  final String? nid;
  final String? nidImg;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final DateTime? createdAt;

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      role: json["role"],
      id: json["_id"],
      country: json["country"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      vehicleType: json["vehicleType"],
      vehicleNumber: json["vehicleNumber"],
      vehicleLicense: json["vehicleLicense"],
      nid: json["NID"],
      nidImg: json["NIDImg"],
      email: json["email"],
      gender: json["gender"],
      phone: json["phone"],
      photo: json["photo"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "role": role,
    "_id": id,
    "country": country,
    "firstName": firstName,
    "lastName": lastName,
    "vehicleType": vehicleType,
    "vehicleNumber": vehicleNumber,
    "vehicleLicense": vehicleLicense,
    "NID": nid,
    "NIDImg": nidImg,
    "email": email,
    "gender": gender,
    "phone": phone,
    "photo": photo,
    "createdAt": createdAt?.toIso8601String(),
  };

  // Convert model to entity
  DriverEntity toEntity() => DriverEntity(
    role: role,
    id: id,
    country: country,
    firstName: firstName,
    lastName: lastName,
    vehicleType: vehicleType,
    vehicleNumber: vehicleNumber,
    vehicleLicense: vehicleLicense,
    nid: nid,
    nidImg: nidImg,
    email: email,
    gender: gender,
    phone: phone,
    photo: photo,
    createdAt: createdAt,
  );

  // Convert entity to model
  factory Driver.fromEntity(DriverEntity entity) => Driver(
    role: entity.role,
    id: entity.id,
    country: entity.country,
    firstName: entity.firstName,
    lastName: entity.lastName,
    vehicleType: entity.vehicleType,
    vehicleNumber: entity.vehicleNumber,
    vehicleLicense: entity.vehicleLicense,
    nid: entity.nid,
    nidImg: entity.nidImg,
    email: entity.email,
    gender: entity.gender,
    phone: entity.phone,
    photo: entity.photo,
    createdAt: entity.createdAt,
  );
}
