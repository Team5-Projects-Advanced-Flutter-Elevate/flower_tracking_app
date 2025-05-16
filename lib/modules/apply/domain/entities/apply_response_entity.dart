import 'package:equatable/equatable.dart';
import '../../../../shared_layers/database/firestore/domain/entities/driver/driver_entity_firestore.dart';

class ApplyResponseEntity extends Equatable {
  const ApplyResponseEntity({this.message, this.driver, this.token});

  final String? message;
  final DriverEntityFirestore? driver;
  final String? token;

  @override
  List<Object?> get props => [message, driver, token];
}
