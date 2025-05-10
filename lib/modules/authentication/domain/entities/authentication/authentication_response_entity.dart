import 'package:flower_tracking_app/modules/authentication/domain/entities/authentication/user_entity.dart';

class AuthenticationResponseEntity {
  String? message;
  UserEntity? user;
  String? token;

  AuthenticationResponseEntity({this.message, this.user, this.token});
}
