import 'package:flower_tracking_app/core/bases/base_data_model.dart';
import 'package:flower_tracking_app/modules/authentication/domain/entities/login/response/login_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

/// message : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkcml2ZXIiOiI2ODFiODY4ZjE0MzNhNjY2YzhkYTEwZTkiLCJpYXQiOjE3NDY2MzQ0NDF9.PBkV3tswaH3a1fj98VCwULr6mBaJh4YgbKz_KV_NorA"

@JsonSerializable(createToJson: false)
class LoginResponseDto extends BaseDataModel {
  LoginResponseDto({this.message, this.token})
    : super(equatableProps: [message, token]);

  factory LoginResponseDto.fromJson(dynamic json) =>
      _$LoginResponseDtoFromJson(json);
  final String? message;
  final String? token;

  LoginResponseEntity convertIntoEntity() {
    return LoginResponseEntity(message: message, token: token);
  }
}
