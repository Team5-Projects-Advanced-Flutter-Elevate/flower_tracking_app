import 'package:equatable/equatable.dart';

class ApplyResponseEntity extends Equatable {
  const ApplyResponseEntity({this.message, this.driver, this.token});

  final String? message;
  final DriverEntity? driver;
  final String? token;

  @override
  // TODO: implement props
  List<Object?> get props => [message, driver, token];
}

class DriverEntity extends Equatable {
  const DriverEntity({
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

  final String? country;
  final String? firstName;
  final String? lastName;
  final String? vehicleType;
  final String? vehicleNumber;
  final String? vehicleLicense;
  final String? nid;
  final String? nIDImg;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final String? id;
  final String? createdAt;

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
