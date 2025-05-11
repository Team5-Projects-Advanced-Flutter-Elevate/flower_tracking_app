import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/modules/apply/domain/entities/apply_response_entity.dart';
import 'package:http_parser/http_parser.dart';
import 'package:json_annotation/json_annotation.dart';

part 'apply_response.g.dart';

@JsonSerializable()
class ApplyResponse extends Equatable {
  const ApplyResponse({this.message, this.driver, this.token});

  factory ApplyResponse.fromJson(dynamic json) => _$ApplyResponseFromJson(json);

  final String? message;
  final Driver? driver;
  final String? token;

  Map<String, dynamic> toJson() => _$ApplyResponseToJson(this);

  ApplyResponseEntity toEntity() => ApplyResponseEntity(
    message: message,
    driver: driver?.toEntity(),
    token: token,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [message, driver, token];
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

  Future<FormData> toFormData() async {
    // Validate required fields
    if (nIDImg == null) throw Exception('National ID image is required');
    if (vehicleLicense == null) throw Exception('Vehicle license is required');
    if (vehicleType == null) throw Exception('Vehicle type is required');

    final formData = FormData();

    // Add ONLY fields that your server expects
    // Based on errors, your server wants very specific field names
    formData.fields.addAll([
      MapEntry('vehicleType', vehicleType!),
      if (country != null) MapEntry('country', country!),
      if (firstName != null) MapEntry('firstName', firstName!),
      if (lastName != null) MapEntry('lastName', lastName!),
      if (vehicleNumber != null) MapEntry('vehicleNumber', vehicleNumber!),
      if (nid != null) MapEntry('NID', nid!),
      if (email != null) MapEntry('email', email!),
      if (password != null) MapEntry('password', password!),
      if (gender != null) MapEntry('gender', gender!),
      if (phone != null) MapEntry('phone', phone!),
      if (rePassword != null) MapEntry('rePassword', rePassword!),
    ]);

    // Add files with EXACT field names the server expects
    formData.files.addAll([
      MapEntry(
        'NIDImg', // Note: different from previous 'NIDImg'
        await createMultipartFile(nIDImg!),
      ),
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
    map['country'] = country;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['vehicleType'] = vehicleType;
    map['vehicleNumber'] = vehicleNumber;
    map['vehicleLicense'] = vehicleLicense;
    map['NID'] = nid;
    map['NIDImg'] = nIDImg;
    map['email'] = email;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['gender'] = gender;
    map['phone'] = phone;
    return map;
  }
}
