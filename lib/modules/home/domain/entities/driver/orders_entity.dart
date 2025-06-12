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

  Metadata copyWith({
    int? currentPage,
    int? totalPages,
    int? totalItems,
    int? limit,
  }) {
    return Metadata(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      limit: limit ?? this.limit,
    );
  }
}

class PendingOrdersEntity {
  final String message;
  final Metadata metadata; // Non-nullable Metadata
  final List<OrderEntity> orders; // Non-nullable List<OrderEntity>

  PendingOrdersEntity({
    required this.message,
    required this.metadata,
    required this.orders,
  });

  PendingOrdersEntity copyWith({
    String? message,
    Metadata? metadata,
    List<OrderEntity>? orders,
  }) {
    return PendingOrdersEntity(
      message: message ?? this.message,
      metadata: metadata ?? this.metadata,
      orders: orders ?? this.orders,
    );
  }
}

class OrderEntity {
  final String id;
  final User user;
  final List<OrderItem> orderItems;
  final double totalPrice;
  final String paymentType;
  final bool isPaid;
  final bool isDelivered;
  final String state;
  final String createdAt;
  final String updatedAt;
  final String orderNumber;
  final Store store;

  OrderEntity({
    required this.id,
    required this.user,
    required this.orderItems,
    required this.totalPrice,
    required this.paymentType,
    required this.isPaid,
    required this.isDelivered,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.orderNumber,
    required this.store,
  });
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String photo;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
  });
}

class OrderItem {
  final Product? product;
  final double price;
  final int quantity;
  final String id;

  OrderItem({
    required this.product,
    required this.price,
    required this.quantity,
    required this.id,
  });
}

class Product {
  final String id;
  final String title;
  final double price;

  Product({required this.id, required this.title, required this.price});
}

class Store {
  final String name;
  final String image;
  final String address;
  final String phoneNumber;
  final String latLong;

  Store({
    required this.name,
    required this.image,
    required this.address,
    required this.phoneNumber,
    required this.latLong,
  });
}

class ShippingAddress {
  final String street;
  final String city;
  final String phone;

  ShippingAddress({
    required this.street,
    required this.city,
    required this.phone,
  });
}
