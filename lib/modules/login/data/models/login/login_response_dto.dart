import 'package:json_annotation/json_annotation.dart';

/// message : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2ODFiODY4ZjE0MzNhNjY2YzhkYTEwZTkiLCJpYXQiOjE3NDY2MzQ0NDF9.PBkV3tswaH3a1fj98VCwULr6mBaJh4YgbKz_KV_NorA"
part 'login_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponseDto {
  LoginResponseDto({this.message, this.token});

  factory LoginResponseDto.fromJson(dynamic json) =>
      _$LoginResponseDtoFromJson(json);
  String? message;
  String? token;
}
