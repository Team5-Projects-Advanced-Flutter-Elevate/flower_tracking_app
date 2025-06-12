import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/home/data/models/driver/driver_order_model.dart';
import 'package:flower_tracking_app/modules/home/data/models/driver/metadata_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/driver/orders_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'pending_orders_model.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class OrdersRemoteDataSource {
  factory OrdersRemoteDataSource(Dio dio, {String baseUrl}) =
      _OrdersRemoteDataSource;

  @GET(ApisEndpoints.driverOrders)
  Future<PendingOrdersModel> getDriverOrders(
    @Query("page") int page,
    @Query("limit") int limit,
  );
}

@JsonSerializable()
class PendingOrdersModel {
  final String message;
  final MetadataModel metadata;
  final List<DriverOrderModel> orders;

  PendingOrdersModel({
    required this.message,
    required this.metadata,
    required this.orders,
  });

  factory PendingOrdersModel.fromJson(Map<String, dynamic> json) =>
      _$PendingOrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$PendingOrdersModelToJson(this);

  PendingOrdersEntity toEntity() => PendingOrdersEntity(
    message: message,
    metadata: metadata.toEntity(),
    orders: orders.map((driverOrder) => driverOrder.toEntity()).toList(),
  );
}
