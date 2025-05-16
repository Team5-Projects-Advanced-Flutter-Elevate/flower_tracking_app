import 'package:dio/dio.dart';
import 'package:flower_tracking_app/core/apis/apis_endpoints/apis_endpoints.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/orders_entity.dart';
import 'package:flower_tracking_app/shared_layers/database/firestore/data/models/order/order_dto_firestore.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_client_model.g.dart';

@RestApi(baseUrl: ApisEndpoints.baseUrl)
abstract class OrdersApiClient {
  factory OrdersApiClient(Dio dio, {String baseUrl}) = _OrdersApiClient;

  @GET(ApisEndpoints.getPendingOrders)
  Future<PendingOrdersResponse> getPendingOrders({@Query("page") int page = 1});
}

@JsonSerializable()
class PendingOrdersResponse {
  final String message;
  final Metadata? metadata;
  final List<OrderDtoFirestore>? orders;

  PendingOrdersResponse({required this.message, this.metadata, this.orders});

  factory PendingOrdersResponse.fromJson(Map<String, dynamic> json) {
    return _$PendingOrdersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PendingOrdersResponseToJson(this);

  PendingOrdersEntity convertIntoEntity() {
    return PendingOrdersEntity(
      message: message,
      orders: orders?.map((e) => e.convertIntoEntity()).toList(),
      metadata: metadata,
    );
  }
}

@JsonSerializable()
class Metadata {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int limit;

  Metadata({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.limit,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}
