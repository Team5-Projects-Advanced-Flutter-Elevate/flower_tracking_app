import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:http_parser/http_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apply_response.g.dart';

@JsonSerializable()
class ApplyResponse {
  ApplyResponse({this.message, this.driver, this.token});

  factory ApplyResponse.fromJson(dynamic json) => _$ApplyResponseFromJson(json);

  String? message;
  Driver? driver;
  String? token;

  Map<String, dynamic> toJson() => _$ApplyResponseToJson(this);

  ApplyResponseEntity toEntity() => ApplyResponseEntity(
    message: message,
    driver: driver?.toEntity(),
    token: token,
  );
}

@JsonSerializable()
class Driver {
  Driver({
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

  factory Driver.fromJson(dynamic json) => _$DriverFromJson(json);

  String? country;
  String? firstName;
  String? lastName;
  String? vehicleType;
  String? vehicleNumber;
  String? vehicleLicense;
  @JsonKey(name: 'NID')
  String? nid;
  @JsonKey(name: 'NIDImg')
  String? nIDImg;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;

  Map<String, dynamic> toJson() => _$DriverToJson(this);

  DriverEntity toEntity() => DriverEntity(
    country: country,
    firstName: firstName,
    lastName: lastName,
    vehicleType: vehicleType,
    vehicleNumber: vehicleNumber,
    vehicleLicense: vehicleLicense,
    nid: nid,
    nIDImg: nIDImg,
    email: email,
    gender: gender,
    phone: phone,
    photo: photo,
    role: role,
    id: id,
    createdAt: createdAt,
  );
}

class DriverRequestModel {
  String? country;
  String? firstName;
  String? lastName;
  String? vehicleType;
  String? vehicleNumber;
  File? vehicleLicense;
  String? nid;
  File? nIDImg;
  String? email;
  String? password;
  String? rePassword;
  String? gender;
  String? phone;

  DriverRequestModel({
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nid,
    this.nIDImg,
    this.email,
    this.password,
    this.rePassword,
    this.gender,
    this.phone,
  });

  void validate() {
    if (vehicleType == null || vehicleType!.isEmpty) {
      throw Exception('Vehicle type is required');
    }
    if (nIDImg == null) {
      throw Exception('National ID image is required');
    }
    if (vehicleLicense == null) {
      throw Exception('Vehicle license image is required');
    }
    // Add other validations as needed
  }

  Future<FormData> toFormData() async {
    // Validate that both required images exist
    if (nIDImg == null) throw Exception('National ID image is required');
    if (vehicleLicense == null) throw Exception('Vehicle license image is required');

    // Create form data with ONLY images first
    final formData = FormData.fromMap({
      'NIDImg': await MultipartFile.fromFile(
        nIDImg!.path,
        filename: 'nid_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
      'vehicleLicense': await MultipartFile.fromFile(
        vehicleLicense!.path,
        filename: 'license_${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
    });

    // Add other fields ONLY if they're not causing the error
    // Some APIs want images first, then other data
    formData.fields.addAll([
      if (vehicleType != null) MapEntry('vehicleType', vehicleType!),
      if (firstName != null) MapEntry('firstName', firstName!),
      if (lastName != null) MapEntry('lastName', lastName!),
      // Add other fields carefully
    ]);

    return formData;
  }
}
