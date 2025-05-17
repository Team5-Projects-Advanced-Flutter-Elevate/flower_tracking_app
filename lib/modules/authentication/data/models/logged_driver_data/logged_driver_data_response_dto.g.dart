// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_driver_data_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoggedDriverDataResponseDto _$LoggedDriverDataResponseDtoFromJson(
  Map<String, dynamic> json,
) => LoggedDriverDataResponseDto(
  message: json['message'] as String?,
  driver:
      json['driver'] == null
          ? null
          : DriverDtoFirestore.fromJson(json['driver']),
  token: json['token'] as String?,
);

Map<String, dynamic> _$LoggedDriverDataResponseDtoToJson(
  LoggedDriverDataResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'driver': instance.driver,
  'token': instance.token,
};
