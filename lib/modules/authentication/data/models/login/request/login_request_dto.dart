import 'package:flower_tracking_app/modules/authentication/domain/entities/login/request/login_request_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../../../core/bases/base_data_model.dart';

part 'login_request_dto.g.dart';

/// email : "klilmohammed9@gmail.com"
/// password : "123456Hh@"
@JsonSerializable(createFactory: false)
class LoginRequestDto extends BaseDataModel {
  LoginRequestDto({this.email, this.password})
    : super(equatableProps: [email, password]);
  final String? email;
  final String? password;

  Map<String, dynamic> toJson() => _$LoginRequestDtoToJson(this);

  static convertIntoDto(LoginRequestEntity loginRequestEntity) {
    return LoginRequestDto(
      email: loginRequestEntity.email,
      password: loginRequestEntity.password,
    );
  }
}
