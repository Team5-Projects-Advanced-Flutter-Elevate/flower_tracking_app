import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_client_model.g.dart';

@RestApi(baseUrl: "https://flower.elevateegy.com/api/v1/")
abstract class OrdersApiClient {
  factory OrdersApiClient(Dio dio, {String baseUrl}) = _OrdersApiClient;

  @GET("orders/pending-orders")
  Future<PendingOrdersResponse> getPendingOrders({
    @Query("page") int page = 1,
  });
}

@JsonSerializable()
class PendingOrdersResponse {
  final String message;
  final Metadata? metadata;
  final List<Order>? orders;

  PendingOrdersResponse({
    required this.message,
    this.metadata,
    this.orders,
  });

  factory PendingOrdersResponse.fromJson(Map<String, dynamic> json) {
    print('Parsing PendingOrdersResponse: $json');
    return _$PendingOrdersResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PendingOrdersResponseToJson(this);
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
    print('Parsing Metadata: $json');
    return _$MetadataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MetadataToJson(this);
}

@JsonSerializable()
class Order {
  @JsonKey(name: '_id')
  final String? id;
  final User? user;
  final List<OrderItem>? orderItems;
  final double? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final String? createdAt;
  final String? updatedAt;
  final String? orderNumber;
  final Store? store;
  final ShippingAddress? shippingAddress;

  Order({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
    this.store,
    this.shippingAddress,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    print('Parsing Order: $json');
    return _$OrderFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    print('Parsing User: $json');
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class OrderItem {
  final Product? product;
  final double? price;
  final int? quantity;
  @JsonKey(name: '_id')
  final String? id;

  OrderItem({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    print('Parsing OrderItem: $json');
    return _$OrderItemFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final double? price;
  final double? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final String? createdAt;
  final String? updatedAt;
  final int? discount;
  final int? sold;

  Product({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.discount,
    this.sold,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    print('Parsing Product: $json');
    return _$ProductFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

@JsonSerializable()
class Store {
  final String? name;
  final String? image;
  final String? address;
  final String? phoneNumber;
  final String? latLong;

  Store({
    this.name,
    this.image,
    this.address,
    this.phoneNumber,
    this.latLong,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    print('Parsing Store: $json');
    return _$StoreFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StoreToJson(this);
}

@JsonSerializable()
class ShippingAddress {
  final String? street;
  final String? city;
  final String? phone;

  ShippingAddress({
    this.street,
    this.city,
    this.phone,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    print('Parsing ShippingAddress: $json');
    return _$ShippingAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}