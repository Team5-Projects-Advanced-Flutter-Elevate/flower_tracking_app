import 'package:flower_tracking_app/modules/authentication/domain/entities/logged_driver_data/logged_driver_data_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../../../../core/models/driver/driver_dto.dart';
part 'logged_driver_data_response_dto.g.dart';

/// message : "success"
/// driver : {"_id":"681c9af21433a666c8da4d98","country":"Egypt","firstName":"Mohammed","lastName":"Khalil","vehicleType":"676b31a45d05310ca82657ac","vehicleNumber":"12221","vehicleLicense":"https://flower.elevateegy.com/uploads/486c5a67-6911-477f-be80-67aa9f7627da-0*e6QF0vjUGkiKSm06.png","NID":"12345678912345","NIDImg":"https://flower.elevateegy.com/uploads/39a39855-0371-438d-b24a-4d1a84033863-0*e6QF0vjUGkiKSm06.png","email":"klilmohammed9@gmail.com","gender":"male","phone":"+201010700888","photo":"https://flower.elevateegy.com/uploads/default-profile.png","role":"driver","createdAt":"2025-05-08T11:52:18.050Z"}
@JsonSerializable()
class LoggedDriverDataResponseDto {
  LoggedDriverDataResponseDto({this.message, this.driver, this.token});

  factory LoggedDriverDataResponseDto.fromJson(dynamic json) =>
      _$LoggedDriverDataResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoggedDriverDataResponseDtoToJson(this);
  String? message;
  DriverDto? driver;
  String? token;

  LoggedDriverDataResponseEntity convertIntoEntity() {
    return LoggedDriverDataResponseEntity(
      message: message,
      driver: driver?.convertIntoEntity(),
      token: token,
    );
  }

  static LoggedDriverDataResponseDto convertIntDto(
    LoggedDriverDataResponseEntity entity,
  ) {
    return LoggedDriverDataResponseDto(
      message: entity.message,
      driver: DriverDto.convertIntoDto(entity.driver),
      token: entity.token,
    );
  }
}
