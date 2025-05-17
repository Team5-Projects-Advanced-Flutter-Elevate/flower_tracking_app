import '../../../../../shared_layers/database/firestore/domain/entities/driver/driver_entity_firestore.dart';

class LoggedDriverDataResponseEntity {
  LoggedDriverDataResponseEntity({this.message, this.driver, this.token});

  String? message;
  DriverEntityFirestore? driver;
  String? token;
}
