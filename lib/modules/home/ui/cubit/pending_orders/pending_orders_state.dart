import 'package:equatable/equatable.dart';
import 'package:flower_tracking_app/modules/home/domain/entities/orders_entity.dart';

enum LoadOrdersStatus { initial, loading, success, error, loadingMore }

class OrdersState extends Equatable {
  final LoadOrdersStatus status;
  final PendingOrdersEntity? orders;
  final Object? error;
  final int currentPage;

  const OrdersState({
    this.status = LoadOrdersStatus.initial,
    this.orders,
    this.error,
    this.currentPage = 1,
  });

  OrdersState copyWith({
    LoadOrdersStatus? status,
    PendingOrdersEntity? orders,
    Object? error,
    int? currentPage,
  }) => OrdersState(
    status: status ?? this.status,
    orders: orders ?? this.orders,
    error: error ?? this.error,
    currentPage: currentPage ?? this.currentPage,
  );

  @override
  List<Object?> get props => [status, orders, error, currentPage];
}

sealed class OrdersIntent {}

class LoadOrdersIntent extends OrdersIntent {}

class LoadMoreOrdersIntent extends OrdersIntent {}

class RefreshOrdersIntent extends OrdersIntent {}

class RejectOrderIntent {
  final String orderId;

  RejectOrderIntent(this.orderId);
}
