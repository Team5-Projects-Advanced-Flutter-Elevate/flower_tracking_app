import 'package:equatable/equatable.dart';

import '../../../../core/entities/driver/driver_entity.dart';

class ApplyResponseEntity extends Equatable {
  const ApplyResponseEntity({this.message, this.driver, this.token});

  final String? message;
  final DriverEntity? driver;
  final String? token;

  @override
  List<Object?> get props => [message, driver, token];
}
