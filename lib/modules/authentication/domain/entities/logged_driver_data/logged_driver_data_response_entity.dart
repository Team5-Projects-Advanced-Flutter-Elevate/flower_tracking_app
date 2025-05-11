import '../../../../../core/entities/driver/driver_entity.dart';

class LoggedDriverDataResponseEntity {
  LoggedDriverDataResponseEntity({this.message, this.driver, this.token});

  String? message;
  DriverEntity? driver;
  String? token;
}
