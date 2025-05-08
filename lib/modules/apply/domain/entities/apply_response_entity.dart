import 'package:equatable/equatable.dart';

class ApplyResponseEntity extends Equatable {
  ApplyResponseEntity({this.message, this.driver, this.token});

  String? message;
  DriverEntity? driver;
  String? token;

  @override
  // TODO: implement props
  List<Object?> get props => [
        message,
        driver,
        token,
  ];
}

class DriverEntity extends Equatable {
  DriverEntity({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nIDImg,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.id,
    this.createdAt,
  });

  String? country;
  String? firstName;
  String? lastName;
  String? vehicleType;
  String? vehicleNumber;
  String? vehicleLicense;
  String? nid;
  String? nIDImg;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  String? id;
  String? createdAt;

  @override
  // TODO: implement props
  List<Object?> get props => [
        country,
        firstName,
        lastName,
        vehicleType,
        vehicleNumber,
        vehicleLicense,
        nid,
        nIDImg,
        email,
        gender,
        phone,
        photo,
        role,
        id,
        createdAt,
  ];
}
