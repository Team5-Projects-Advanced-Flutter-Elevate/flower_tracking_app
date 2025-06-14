import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../../domain/entities/edite_profile_entity.dart';

class EditProfileResponse {
  String? message;
  Driver? driver;

  EditProfileResponse({this.message, this.driver});

  EditProfileResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    driver = json['driver'] != null ? Driver.fromJson(json['driver']) : null;
  }

  EditProfileEntity toEntity() {
    return EditProfileEntity(message: message, driver: driver?.toEntity());
  }
}

class Driver {
  String? sId;
  String? country;
  String? firstName;
  String? lastName;
  String? vehicleType;
  String? vehicleNumber;
  String? vehicleLicense;
  String? nID;
  String? nIDImg;
  String? email;
  String? password;
  String? gender;
  String? phone;
  String? photo;
  String? createdAt;
  String? passwordChangedAt;
  String? passwordResetCode;
  String? passwordResetExpires;
  bool? resetCodeVerified;
  String? role;

  Driver({
    this.sId,
    this.country,
    this.firstName,
    this.lastName,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
    this.nID,
    this.nIDImg,
    this.email,
    this.password,
    this.gender,
    this.phone,
    this.photo,
    this.createdAt,
    this.passwordChangedAt,
    this.passwordResetCode,
    this.passwordResetExpires,
    this.resetCodeVerified,
    this.role,
  });

  Driver.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    country = json['country'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    vehicleType = json['vehicleType'];
    vehicleNumber = json['vehicleNumber'];
    vehicleLicense = json['vehicleLicense'];
    nID = json['NID'];
    nIDImg = json['NIDImg'];
    email = json['email'];
    password = json['password'];
    gender = json['gender'];
    phone = json['phone'];
    photo = json['photo'];
    createdAt = json['createdAt'];
    passwordChangedAt = json['passwordChangedAt'];
    passwordResetCode = json['passwordResetCode'];
    passwordResetExpires = json['passwordResetExpires'];
    resetCodeVerified = json['resetCodeVerified'];
    role = json['role'];
  }

  DriverEntity toEntity() {
    return DriverEntity(
      sId: sId,
      country: country,
      firstName: firstName,
      lastName: lastName,
      vehicleType: vehicleType,
      vehicleNumber: vehicleNumber,
      vehicleLicense: vehicleLicense,
      nID: nID,
      nIDImg: nIDImg,
      email: email,
      password: password,
      gender: gender,
      phone: phone,
      photo: photo,
      createdAt: createdAt,
      passwordChangedAt: passwordChangedAt,
      passwordResetCode: passwordResetCode,
      passwordResetExpires: passwordResetExpires,
      resetCodeVerified: resetCodeVerified,
      role: role,
    );
  }
}

class EditVehicleRequest {
  String? vehicleType;
  String? vehicleNumber;
  File? vehicleLicense;

  EditVehicleRequest({
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleLicense,
  });

  Future<FormData> toFormData() async {
    final formData = FormData();

    // Add files with EXACT field names the server expects
    formData.files.addAll([
      MapEntry(
        'vehicleLicense', // Not in array format
        await createMultipartFile(vehicleLicense!),
      ),
    ]);

    return formData;
  }

  Future<MultipartFile> createMultipartFile(File file) async {
    final extension = file.path.split('.').last.toLowerCase();
    final mimeType = extension == 'png' ? 'png' : 'jpeg';

    return await MultipartFile.fromFile(
      file.path,
      filename: '${file.path.split('.').first}.$extension',
      contentType: MediaType('image', mimeType),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicleType'] = vehicleType;
    map['vehicleNumber'] = vehicleNumber;
    map['vehicleLicense'] = vehicleLicense;
    return map;
  }
}
