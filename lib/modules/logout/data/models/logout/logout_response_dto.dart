import 'package:flower_tracking_app/modules/logout/domain/entities/logout/logout_response_entity.dart';

/// message : "success"
class LogoutResponseDto {
  LogoutResponseDto({this.message});

  LogoutResponseDto.fromJson(dynamic json) {
    message = json['message'];
  }

  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

  LogoutResponseEntity convertIntoEntity() {
    return LogoutResponseEntity(message: message);
  }
}
