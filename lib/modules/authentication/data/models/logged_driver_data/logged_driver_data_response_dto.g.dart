// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_driver_data_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedDriverDataResponseDto _$LoggedDriverDataResponseDtoFromJson(
  Map<String, dynamic> json,
) => LoggedDriverDataResponseDto(
  message: json['message'] as String?,
  driver: json['driver'] == null ? null : DriverDto.fromJson(json['driver']),
  token: json['token'] as String?,
);

Map<String, dynamic> _$LoggedDriverDataResponseDtoToJson(
  LoggedDriverDataResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'driver': instance.driver,
  'token': instance.token,
};

DriverDto _$DriverDtoFromJson(Map<String, dynamic> json) => DriverDto(
  id: json['_id'] as String?,
  country: json['country'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  vehicleType: json['vehicleType'] as String?,
  vehicleNumber: json['vehicleNumber'] as String?,
  vehicleLicense: json['vehicleLicense'] as String?,
  nid: json['NID'] as String?,
  nIDImg: json['NIDImg'] as String?,
  email: json['email'] as String?,
  gender: json['gender'] as String?,
  phone: json['phone'] as String?,
  photo: json['photo'] as String?,
  role: json['role'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$DriverDtoToJson(DriverDto instance) => <String, dynamic>{
  '_id': instance.id,
  'country': instance.country,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'vehicleType': instance.vehicleType,
  'vehicleNumber': instance.vehicleNumber,
  'vehicleLicense': instance.vehicleLicense,
  'NID': instance.nid,
  'NIDImg': instance.nIDImg,
  'email': instance.email,
  'gender': instance.gender,
  'phone': instance.phone,
  'photo': instance.photo,
  'role': instance.role,
  'createdAt': instance.createdAt,
};
