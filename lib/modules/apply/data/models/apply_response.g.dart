// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyResponse _$ApplyResponseFromJson(Map<String, dynamic> json) =>
    ApplyResponse(
      message: json['message'] as String?,
      driver:
          json['driver'] == null ? null : DriverDto.fromJson(json['driver']),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ApplyResponseToJson(ApplyResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'driver': instance.driver,
      'token': instance.token,
    };
